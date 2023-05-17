        .text
        .type gemm_asm_sve_32_6_1, %function
        .global gemm_asm_sve_32_6_1
        /*
         * Performs the matrix-multiplication C+=A*B
         * with the shapes (32x6) = (32x1) * (1x6).
         * The input-data is of type float.
         *
         * @param x0 pointer to A.
         * @param x1 pointer to B.
         * @param x2 pointer to C.
         */ 
gemm_asm_sve_32_6_1:
        // set all bits of predicate register p0 to 1
        ptrue p0.b


        //___________________________________________________________________
        //___________________________________________________________________

        // your matrix kernel goes here!
        // we will always have matrix B in the registers.
        // elements of A will be overwritten after every row of C
        // the result of the FMA will be directly written to memory of C
        // the matrix C is assumed to be stored in transposed version for more efficient memory loads and stores in this column major memory implementation.

        // load all of A and all of B into registers
        ldr z0, [x0]
        addvl x0, x0, #1    // I know we can assume 256 bit vectors but this is stil more general
        ldr z1, [x0]
        addvl x0, x0, #1
        ldr z2, [x0]
        addvl x0, x0, #1
        ldr z3, [x0]
        addvl x0, x0, #1

        // load first value of B into all pipelines to be multiplied with all values of A
        ld1rw z4.s, p0/z, [x1]
        add x1, x1, #4

        //load first 32 values of C
        ldr z5, [x2]
        ldr z6, [x2, #1, mul vl]
        ldr z7, [x2, #2, mul vl]
        ldr z16, [x2, #3, mul vl]

        // second column
        ld1rw z17.s, p0/z, [x1]
        add x1, x1, #4

        ldr z18, [x2]
        ldr z19, [x2, #1, mul vl]
        ldr z20, [x2, #2, mul vl]
        ldr z21, [x2, #3, mul vl]

        // third column
        ld1rw z22.s, p0/z, [x1]
        add x1, x1, #4

        ldr z23, [x2]
        ldr z24, [x2, #1, mul vl]
        ldr z25, [x2, #2, mul vl]
        ldr z26, [x2, #3, mul vl]

        // fourt column
        ld1rw z27.s, p0/z, [x1]
        add x1, x1, #4

        ldr z28, [x2]
        ldr z29, [x2, #1, mul vl]
        ldr z30, [x2, #2, mul vl]
        ldr z31, [x2, #3, mul vl]

        // do FMA C+=A*B for first column of C
        fmla z5.s, p0/m, z0.s, z4.s
        fmla z6.s, p0/m, z1.s, z4.s
        fmla z7.s, p0/m, z2.s, z4.s
        fmla z16.s, p0/m, z3.s, z4.s

        // do FMA C+=A*B for second column of C
        fmla z18.s, p0/m, z1.s, z17.s
        fmla z19.s, p0/m, z2.s, z17.s
        fmla z20.s, p0/m, z3.s, z17.s
        fmla z21.s, p0/m, z0.s, z17.s

        // do FMA C+=A*B for third column of C
        fmla z23.s, p0/m, z0.s, z22.s
        fmla z24.s, p0/m, z1.s, z22.s
        fmla z25.s, p0/m, z2.s, z22.s
        fmla z26.s, p0/m, z3.s, z22.s

        // do FMA C+=A*B for fourth column of C
        fmla z28.s, p0/m, z0.s, z27.s
        fmla z29.s, p0/m, z1.s, z27.s
        fmla z30.s, p0/m, z2.s, z27.s
        fmla z31.s, p0/m, z3.s, z27.s

        // store first 16 elements of C to memory
        str z5, [x2]
        str z6, [x2, #1, mul vl]
        str z7, [x2, #2, mul vl]
        str z16, [x2, #3, mul vl]

        str z18, [x2, #4, mul vl]
        str z19, [x2, #5, mul vl]
        str z20, [x2, #6, mul vl]
        str z21, [x2, #7, mul vl]

        str z23, [x2, #8, mul vl]
        str z24, [x2, #9, mul vl]
        str z25, [x2, #10, mul vl]
        str z26, [x2, #11, mul vl]

        str z28, [x2, #12, mul vl]
        str z29, [x2, #13, mul vl]
        str z30, [x2, #14, mul vl]
        str z31, [x2, #15, mul vl]
        addvl x2, x2, #16

        // b = 4 of 6


        // load fifth value of B into all pipelines to be multiplied with all values of A
        ptrue p0.s
        ld1rw z4.s, p0/z, [x1]
        add x1, x1, #4

        //load fifth 32 values of C
        ldr z5, [x2]
        ldr z6, [x2, #1, mul vl]
        ldr z7, [x2, #2, mul vl]
        ldr z16, [x2, #3, mul vl]

        // do FMA C+=A*B for fifth 32 elements of C
        fmla z5.s, p0/m, z0.s, z4.s
        fmla z6.s, p0/m, z1.s, z4.s
        fmla z7.s, p0/m, z2.s, z4.s
        fmla z16.s, p0/m, z3.s, z4.s

        // store fifth 32 elements of C to memory
        str z5, [x2]
        str z6, [x2, #1, mul vl]
        str z7, [x2, #2, mul vl]
        str z16, [x2, #3, mul vl]
        addvl x2, x2, #4

        // b = 5 of 6


        // load sixth value of B into all pipelines to be multiplied with all values of A
        ptrue p0.s
        ld1rw z4.s, p0/z, [x1]
        add x1, x1, #4

        //load sixth 32 values of C
        ldr z5, [x2]
        ldr z6, [x2, #1, mul vl]
        ldr z7, [x2, #2, mul vl]
        ldr z16, [x2, #3, mul vl]

        // do FMA C+=A*B for sixth 32 elements of C
        fmla z5.s, p0/m, z0.s, z4.s
        fmla z6.s, p0/m, z1.s, z4.s
        fmla z7.s, p0/m, z2.s, z4.s
        fmla z16.s, p0/m, z3.s, z4.s

        // store sixth 32 elements of C to memory
        str z5, [x2]
        str z6, [x2, #1, mul vl]
        str z7, [x2, #2, mul vl]
        str z16, [x2, #3, mul vl]
        addvl x2, x2, #4

        // b = 6 of 6

        //___________________________________________________________________
        //___________________________________________________________________

        ret
        .size gemm_asm_sve_32_6_1, (. - gemm_asm_sve_32_6_1)