
	AREA	program, CODE, READONLY
matrix_mul
	EXPORT	matrix_mul

    ; Please write your code below that will implement:
    ;       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);
	;r0 r1 r2 is used for the matrixes
;mn*nk
	ldr r3,[r1,#4]
	ldr r4,[r2]
	cmp r3,r4 ;can do multi?
	movne r0,#1 ;if not
	bne all_finish ;if not
	ldr r4,[r1]
	ldr r5,[r2,#4]
	str r4,[r0]
	str r5,[r0,#4]	
	ldr r6,[r1,#8];m1 arr
	ldr r7,[r2,#8];m2 arr
	ldr r8,[r0,#8];m0 arr
	;r6=m1;r7=m2;r8=m0
	;r3=n r4=m r5=k ans=m*k
	push{r0,r1,r2}
	mov r0,#0
	mov r1,#0
	mul r2,r4,r5
	
loop0 
	cmp r0,r4;r0<m
	bge endloop0
	mov r1,#0
loop1 
	cmp r1,r5 ;r1<k
	bge endloop1
	mov r10,#0 ;tmp=0
	mov r9,#0 ; 
	push {r8,r2}
loop2 
	cmp r9,r3 ;r9<n,r0
	bge endloop2
	push {r9,r0}
	mul r0,r0,r3
	add r9,r9,r0
	lsl r9,r9,#2
	ldr r8,[r6,r9]
	pop {r9,r0}
	push {r9,r1}
	mul r9,r9,r5
	add r9,r9,r1
	lsl r9,r9,#2
	ldr r2,[r7,r9]
	pop {r9,r1}
	mla r10,r8,r2,r10
	add r9,#1
	b loop2
endloop2
	pop {r8,r2}
	push {r0,r1}
	mul r0,r0,r5
	add r0,r0,r1
	lsl r0,r0,#2
	str r10,[r8,r0]
	pop {r0,r1}
	add r1,r1,#1
	b loop1
endloop1
	add r0,r0,#1
	b loop0
endloop0
	pop{r0,r1,r2}
	mov r0,#0 ; if success
all_finish
	BX		LR
	END