#![feature(channel_attributes)]  

pub struct  Stream {
    tdata: u32,
    tkeep: u4,
    tlast: u1,
    tfirst: u1,
}

pub struct StreamCleanerState {
    in_a_packet: u1,
}

pub proc stream_cleaner {
    input_ch: chan<Stream> in;
    output_ch: chan<Stream> out;

    config(input_ch: chan<Stream> in, output_ch: chan<Stream> out) { (input_ch, output_ch) }

    init {
        StreamCleanerState { in_a_packet: u1:0 }
    }

    next(st: StreamCleanerState) {
        let (tok, data) = recv(join(), input_ch);
        send_if(tok, output_ch, st.in_a_packet || data.tfirst,  data);

        let in_a_packet_next = if st.in_a_packet { !(data.tlast) } else { data.tfirst & !data.tlast };
        StreamCleanerState { in_a_packet: in_a_packet_next }
    }
}

pub struct StripFcsState {
    in_a_packet: u1,
    stream_prev: Stream,
}

pub proc strip_fcs {
    input_ch: chan<Stream> in;
    output_ch: chan<Stream> out;

    config(input_ch: chan<Stream> in, output_ch: chan<Stream> out) { (input_ch, output_ch) }

    init {
        StripFcsState {
            in_a_packet: u1:0,
            stream_prev: Stream { tdata: u32:0, tkeep: u4:0, tlast: u1:0, tfirst: u1:0, },
        }
    }

    next(st: StripFcsState) {
        let (tok, stream) = recv(join(), input_ch);

        let should_send_a_beat = st.in_a_packet;
        let in_a_packet_next = !stream.tlast;

        send_if(tok, output_ch, should_send_a_beat, Stream {
            tdata:  st.stream_prev.tdata,
            tkeep:  stream.tkeep,
            tlast:  stream.tlast,
            tfirst: st.stream_prev.tfirst,
        });

        StripFcsState { in_a_packet: in_a_packet_next, stream_prev: stream }
    }
}

pub proc stream_cleaner_and_strip_fcs {
    input_ch: chan<Stream> in;
    output_ch: chan<Stream> out;

    config(input_ch: chan<Stream> in, output_ch: chan<Stream> out) {
        let (intermediate_p, intermediate_c) = #[channel(depth=0)] chan<Stream>("cleaner_to_strip_fcs");
        spawn stream_cleaner(input_ch, intermediate_p);
        spawn strip_fcs(intermediate_c, output_ch);
        (input_ch, output_ch)
    }

    // no state and nothing to do in next since we're just joinng things together.
    init { }
    next(_ : ()) { }
}