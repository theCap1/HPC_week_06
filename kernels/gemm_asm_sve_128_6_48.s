        .text
        .type gemm_asm_sve_128_6_48, %function
        .global gemm_asm_sve_128_6_48
        /*
         * Performs the matrix-multiplication C+=A*B
         * with the shapes (32x6) = (32x1) * (1x6).
         * The input-data is of type float.
         *
         * @param x0 pointer to A.
         * @param x1 pointer to B.
         * @param x2 pointer to C.
         */ 
gemm_asm_sve_128_6_48:
        // set all bits of predicate register p0 to 1
        ptrue p0.b


        //___________________________________________________________________
        //___________________________________________________________________

        // your matrix kernel goes here!
        // we will always have matrix B in the registers.
        // elements of A will be overwritten after every row of C
        // the result of the FMA will be directly written to memory of C
        // the matrix C is assumed to be stored in transposed version for more efficient memory loads and stores in this column major memory implementation.

        // loop counter for k
        mov w17, 2

        loop_k: // // loop over columns of A and rows of B
        // loop counter for m
        mov w18, 4
                loop_m: // loops through one column of A
                        // load 1/4 of a column A into registers
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

                        // do FMA C+=A*B for first elements of C
                        fmla z5.s, p0/m, z0.s, z4.s
                        fmla z6.s, p0/m, z1.s, z4.s
                        fmla z7.s, p0/m, z2.s, z4.s
                        fmla z16.s, p0/m, z3.s, z4.s

                        // store first 16 elements of C to memory
                        str z5, [x2]
                        str z6, [x2, #1, mul vl]
                        str z7, [x2, #2, mul vl]
                        str z16, [x2, #3, mul vl]
                        addvl x2, x2, #4

                        // b = 1 of 6


                        // load second value of B into all pipelines to be multiplied with all values of A
                        ptrue p0.s
                        ld1rw z4.s, p0/z, [x1]
                        add x1, x1, #4

                        //load second 32 values of C
                        ldr z5, [x2]
                        ldr z6, [x2, #1, mul vl]
                        ldr z7, [x2, #2, mul vl]
                        ldr z16, [x2, #3, mul vl]

                        // do FMA C+=A*B for second 32 elements of C
                        fmla z5.s, p0/m, z0.s, z4.s
                        fmla z6.s, p0/m, z1.s, z4.s
                        fmla z7.s, p0/m, z2.s, z4.s
                        fmla z16.s, p0/m, z3.s, z4.s

                        // store second 32 elements of C to memory
                        str z5, [x2]
                        str z6, [x2, #1, mul vl]
                        str z7, [x2, #2, mul vl]
                        str z16, [x2, #3, mul vl]
                        addvl x2, x2, #4

                        // b = 2 of 6


                        // load third value of B into all pipelines to be multiplied with all values of A
                        ptrue p0.s
                        ld1rw z4.s, p0/z, [x1]
                        add x1, x1, #4

                        //load third 32 values of C
                        ldr z5, [x2]
                        ldr z6, [x2, #1, mul vl]
                        ldr z7, [x2, #2, mul vl]
                        ldr z16, [x2, #3, mul vl]

                        // do FMA C+=A*B for third 32 elements of C
                        fmla z5.s, p0/m, z0.s, z4.s
                        fmla z6.s, p0/m, z1.s, z4.s
                        fmla z7.s, p0/m, z2.s, z4.s
                        fmla z16.s, p0/m, z3.s, z4.s

                        // store third 32 elements of C to memory
                        str z5, [x2]
                        str z6, [x2, #1, mul vl]
                        str z7, [x2, #2, mul vl]
                        str z16, [x2, #3, mul vl]
                        addvl x2, x2, #4

                        // b = 3 of 6


                        // load fourth value of B into all pipelines to be multiplied with all values of A
                        ptrue p0.s
                        ld1rw z4.s, p0/z, [x1]
                        add x1, x1, #4

                        //load fourth 32 values of C
                        ldr z5, [x2]
                        ldr z6, [x2, #1, mul vl]
                        ldr z7, [x2, #2, mul vl]
                        ldr z16, [x2, #3, mul vl]

                        // do FMA C+=A*B for fourth 32 elements of C
                        fmla z5.s, p0/m, z0.s, z4.s
                        fmla z6.s, p0/m, z1.s, z4.s
                        fmla z7.s, p0/m, z2.s, z4.s
                        fmla z16.s, p0/m, z3.s, z4.s

                        // store fourth 32 elements of C to memory
                        str z5, [x2]
                        str z6, [x2, #1, mul vl]
                        str z7, [x2, #2, mul vl]
                        str z16, [x2, #3, mul vl]
                        addvl x2, x2, #4

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
                        
                        //go back to initial address of B
                        sub x1, x1, #24

                        // k loop condition
                        subs w18, w18, #1
                        bne loop_m

                // go back to initial address of C
                addvl x2, x2, #-32
                addvl x2, x2, #-32
                addvl x2, x2, #-32
                // go to next row of B
                add x1, x1, #24

                // k loop condition
                subs w17, w17, #1
                bne loop_k

        ret
        .size gemm_asm_sve_128_6_48, (. - gemm_asm_sve_128_6_48)