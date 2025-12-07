pub struct  Stream {
    tdata: u32,
    tkeep: u4,
    tlast: u1,
    tfirst: u1,
}

pub struct State {
    in_a_packet: u1,
}

pub proc stream_cleaner {
    input_ch: chan<Stream> in;
    output_ch: chan<Stream> out;

    config(input_ch: chan<Stream> in, output_ch: chan<Stream> out) { (input_ch, output_ch) }

    init {
        State { in_a_packet: u1:0 }
    }

    next(st: State) {
        let (tok, data) = recv(join(), input_ch);
        send_if(tok, output_ch, st.in_a_packet || data.tfirst,  data);

        let in_a_packet_next = if st.in_a_packet { !(data.tlast) } else { data.tfirst & !data.tlast };
        State { in_a_packet: in_a_packet_next }
    }
}
