      SUBROUTINE SETOPENBC2
C  
C CHANGE RECORD  
C ** SUBROUTINE SETOBC SETS OPEN BOUNDARY CONDITIONS FOR
C    CALPUV2T & CALPUV2C   AND  CALPUV9 & CALPUV9C
C  
C *** MODIFIED BY PAUL M. CRAIG
C      
      USE GLOBAL  
C  
C *** SET OPEN BOUNDARY SURFACE ELEVATIONS FOR ADJACENT CELLS, 
C *** IF NOT RADIATION SEPARATION SPECIFICED
C
      DO LL=1,NPBW
        IF(ISPBW(LL).EQ.0)THEN
          L=LPBW(LL)
          CW(L+1)=0.
        ENDIF
      ENDDO
C
      DO LL=1,NPBE
        IF(ISPBE(LL).EQ.0)THEN
          L=LPBE(LL)
          CE(L-1)=0.
        ENDIF
      ENDDO
C
      DO LL=1,NPBS
        IF(ISPBS(LL).EQ.0)THEN
          L=LPBS(LL)
          LN=LNC(L)
          CS(LN)=0.
        ENDIF
      ENDDO
C
      DO LL=1,NPBN
        IF(ISPBN(LL).EQ.0)THEN
          L=LPBN(LL)
          LS=LSC(L)
          CN(LS)=0.
        ENDIF
      ENDDO

      RETURN
      END
