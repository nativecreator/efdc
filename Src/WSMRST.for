      SUBROUTINE WSMRST  
C  
C CHANGE RECORD  
C WRITE SPATIAL DISTRIBUTIONS AT THE END OF SIMULATION TO UNIT ISMORST.  
C  
      USE GLOBAL  
C  
C      LOGICAL FEXIST  
C WRITE ASCII RESTART FILE:  
C  
      OPEN(1,FILE='WQSDRST.OUT',STATUS='UNKNOWN')  
      CLOSE(1,STATUS='DELETE')  
      OPEN(1,FILE='WQSDRST.OUT',STATUS='UNKNOWN')  
      IF(ISDYNSTP.EQ.0)THEN  
        TIME=DT*FLOAT(N)+TCON*TBEGIN  
        TIME=TIME/TCON  
      ELSE  
        TIME=TIMESEC/TCON  
      ENDIF  
      WRITE(1,101) N,TIME  
      WRITE(1,888)  
      DO L=2,LA  
        WRITE(1,90) L,(SMPON(L,NW),NW=1,NSMG),  
     &      (SMPOP(L,NW),NW=1,NSMG),(SMPOC(L,NW),NW=1,NSMG),SM1NH4(L),  
     &      SM2NH4(L),SM2NO3(L),SM2PO4(L),SM2H2S(L),SMPSI(L),SM2SI(L),  
     &      SMBST(L),SMT(L)  
      ENDDO  
      CLOSE(1)  
C  
C ALSO WRITE BINARY RESTART FILE:  
C  
   90 FORMAT(I5, 1P, 18E12.4)  
  101 FORMAT('CC  SM RESTART FILE TIME STEP, TIME = ',I10,F13.5)  
  888 FORMAT('    L',  
     &    '       GPON1       GPON2       GPON3       GPOP1      
     & GPOP2','       GPOP3       GPOC1       GPOC2       GPOC3      
     & G1NH4','       G2NH4       G2NO3       G2PO4       G2H2S       
     & GPSI','        G2SI        GBST          GT')  
      RETURN  
      END  

