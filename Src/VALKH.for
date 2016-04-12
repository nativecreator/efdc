      REAL FUNCTION VALKH(HFFDG)  
C  
C CHANGE RECORD  
C  
      USE GLOBAL  
      IF(HFFDG.LE.0.02)THEN  
        VALKH=HFFDG*HFFDG  
        RETURN  
      ENDIF  
      IF(HFFDG.GE.10.)THEN  
        VALKH=HFFDG  
        RETURN  
      ENDIF  
      DO NTAB=2,1001  
        FTMPM1=FUNKH(NTAB-1)  
        FTMP  =FUNKH(NTAB  )  
        IF(FTMPM1.LE.HFFDG.AND.HFFDG.LT.FTMP)THEN  
          VALKH=RKHTAB(NTAB)  
     &        -(RKHTAB(NTAB)-RKHTAB(NTAB-1))*(FTMP-HFFDG)/(FTMP-FTMPM1)  
          RETURN  
        ENDIF  
      ENDDO  
      IF(NTAB.EQ.1001)THEN  
        WRITE(6,600) RKHTAB(1001)  
        WRITE(8,600) RKHTAB(1001)  
        STOP  
      ENDIF  
C  
C **  INITIALIZE WAVE DISPERSION RELATION TABLE  
C           DRDF=(RKH(M+1)-RKH(M))/(FRKH(M+1)-FRKH(M))  
C           GOTO 200  
C  200 CONTINUE  
C  
  600 FORMAT(' WAVE DISPERSION TABLE OUT OF BOUNDS KH = ',E12.4)  
      RETURN  
      END  

