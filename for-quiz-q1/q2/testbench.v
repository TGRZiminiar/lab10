module half_adder(
    output s,c,
    input x, y
);
    xor(s, x, y);
    and(c, x, y);

endmodule

module full_adder(
    output s,c,
    input x, y, z  
);
    wire s1, c1, c2;
    half_adder HA1(s1, c1, x, y);
    half_adder HA2(s, c2, s1, z);

endmodule