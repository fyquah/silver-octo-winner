pub struct  Stream {
    tdata: u32,
    tkeep: u4,
    tlast: u1,
    tfirst: u1,
}

pub struct State {
    in_a_packet: u1,
    stream_prev: Stream,
}

pub proc strip_fcs {
    input_ch: chan<Stream> in;
    output_ch: chan<Stream> out;

    config(input_ch: chan<Stream> in, output_ch: chan<Stream> out) { (input_ch, output_ch) }

    init {
        State {
            in_a_packet: u1:0,
            stream_prev: Stream { tdata: u32:0, tkeep: u4:0, tlast: u1:0, tfirst: u1:0, },
        }
    }

    next(st: State) {
        let (tok, stream) = recv(join(), input_ch);

        let should_send_a_beat = st.in_a_packet;
        let in_a_packet_next = !stream.tlast;

        send_if(tok, output_ch, should_send_a_beat, Stream {
            tdata:  st.stream_prev.tdata,
            tkeep:  stream.tkeep,
            tlast:  stream.tlast,
            tfirst: st.stream_prev.tfirst,
        });

        State { in_a_packet: in_a_packet_next, stream_prev: stream }
    }
}
