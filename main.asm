					.686
					.model flat,c
					.stack 100h
printf				PROTO			arg1:Ptr			byte,printlist:VARARG
scanf				PROTO			arg2:Ptr			byte,inputlist:VARARG
					.data
arry				sdword		100	dup(?)
n					sdword			?
num					sdword			?
in1fmt				byte			"%d",0
msg1fmt				byte		 0Ah,"%s",0
msg2fmt				byte			"%d, ",0
msg1				byte		"Enter number of integers in array: ",0
msg2				byte		"Enter an integer: ",0
msg3				byte		"Original array: ",0
msg4				byte		"Sorted array: ",0
					.code
main				proc
					INVOKE printf,ADDR msg1fmt,ADDR msg1
					INVOKE scanf,ADDR in1fmt,ADDR n
					;; ================== input into arry =====================
					mov ecx,n
					mov edi,offset arry+0
		while01:	cmp ecx,0
					jle endw01
					push ecx
					INVOKE printf,ADDR msg1fmt,ADDR msg2
					INVOKE scanf,ADDR in1fmt,ADDR [edi]
					add edi,4
					pop ecx
					dec ecx
					jmp while01
		endw01:		;;nop
					;; ========================================================
		if01:		cmp n,0
					jle endif01	
		then01:		;; ================= display original arry ================
					INVOKE printf,ADDR msg1fmt,ADDR msg3
					mov ecx,n
					mov esi,offset arry+0
		while02:	cmp ecx,0	
					jle endw02
					push ecx
					mov eax,[esi]
					mov num,eax
					INVOKE printf,ADDR msg2fmt, num
					add esi,4
					pop ecx
					dec ecx
					jmp while02
		endw02:		;;nop
					;; ========================================================
					;; ==================== selection sort ====================
					mov ecx,n
		if02:		cmp ecx,1
					jle endif02
		then02:		dec ecx
					mov edi,offset arry+0
		while03:	cmp ecx,0
					jle endw03
					push ecx
					push edi
					mov esi,edi
					add esi,4

		while04:	cmp ecx,0
					jle endw04
					mov eax,[edi]
		if03:		cmp [esi],eax
					jge endif03
		then03:		mov edi,esi
		endif03:	;;nop
					add esi,4
					dec ecx
					jmp while04
		endw04:		;;nop

					mov esi,edi
					pop edi
					mov eax,[esi]
					xchg eax,[edi]
					mov [esi],eax
					add edi,4
					pop ecx
					dec ecx
					jmp while03
		endw03:		;;nop
					;; ========================================================	
		endif02:	;;nop
					;; ================= display sorted arry =================
					INVOKE printf,ADDR msg1fmt,ADDR msg4
					mov ecx,n
					mov esi,offset arry+0
		while05:	cmp ecx,0
					jle endw05
					push ecx
					mov eax,[esi]
					mov num,eax
					INVOKE printf,ADDR msg2fmt, num
					add esi,4
					pop ecx
					dec ecx
					jmp while05
		endw05:		;;nop
					;; ========================================================	
		endif01:	;;nop

					ret
main				endp
					end