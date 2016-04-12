      SUBROUTINE CBALOD5  
C  
C CHANGE RECORD  
C **  SUBROUTINES CBALOD CALCULATE GLOBAL VOLUME, MASS, MOMENTUM,  
C **  AND ENERGY BALANCES  
C  
      USE GLOBAL  
C  
C **  CHECK FOR END OF BALANCE PERIOD  
C  
      NTMPD2=NTSMMT/2  
      IF(NBALO.EQ.NTMPD2)THEN  
C  
C **  CALCULATE ENDING VOLUME, SALT MASS, DYE MASS, MOMENTUM, KINETIC  
C **  ENERGY AND POTENTIAL ENERGY, AND ASSOCIATED FLUXES  
C  
        VOLENDO=0.  
        SALENDO=0.  
        DYEENDO=0.  
        UMOENDO=0.  
        VMOENDO=0.  
        UUEENDO=0.  
        VVEENDO=0.  
        PPEENDO=0.  
        BBEENDO=0.  
        DO L=2,LA  
          LN=LNC(L)  
          VOLENDO=VOLENDO+SPB(L)*DXYP(L)*HP(L)  
          UMOENDO=UMOENDO+SPB(L)*0.5*DXYP(L)*HP(L)*(DYIU(L)*HUI(L)
     &*UHDYE(L)                +DYIU(L+1)*HUI(L+1)*UHDYE(L+1))  
          VMOENDO=VMOENDO+SPB(L)*0.5*DXYP(L)*HP(L)*(DXIV(L)*HVI(L)
     &*VHDXE(L)                +DXIV(LN)*HVI(LN)*VHDXE(LN))  
          PPEENDO=PPEENDO+SPB(L)*0.5*DXYP(L)  
     &        *(GI*P(L)*P(L)-G*BELV(L)*BELV(L))  
        ENDDO  
        AMOENDO=SQRT(UMOENDO*UMOENDO+VMOENDO*VMOENDO)  
        DO K=1,KC  
          DO L=2,LA  
            LN=LNC(L)  
            SALENDO=SALENDO+SCB(L)*DXYP(L)*HP(L)*SAL(L,K)*DZC(K)  
            DYEENDO=DYEENDO+SCB(L)*DXYP(L)*HP(L)*DYE(L,K)*DZC(K)  
            UUEENDO=UUEENDO+SPB(L)*0.125*DXYP(L)*HP(L)*DZC(K)  
     &          *( (U(L,K)+U(L+1,K))*(U(L,K)+U(L+1,K)) )  
            VVEENDO=VVEENDO+SPB(L)*0.125*DXYP(L)*HP(L)*DZC(K)  
     &          *( (V(L,K)+V(LN,K))*(V(L,K)+V(LN,K)) )  
            BBEENDO=BBEENDO+SPB(L)*GP*DXYP(L)*HP(L)*DZC(K)*( BELV(L)  
     &          +0.5*HP(L)*(Z(K)+Z(K-1)) )*B(L,K)  
          ENDDO  
        ENDDO  
        UUEOUTO=DT2*UUEOUTO  
        VVEOUTO=DT2*VVEOUTO  
        PPEOUTO=DT2*PPEOUTO  
        BBEOUTO=DT2*BBEOUTO  
        VOLOUTO=DT2*VOLOUTO  
        SALOUTO=DT2*SALOUTO  
        DYEOUTO=DT2*DYEOUTO  
        UMOOUTO=DT2*UMOOUTO  
        VMOOUTO=DT2*VMOOUTO  
        ENEBEGO=UUEBEGO+VVEBEGO+PPEBEGO+BBEBEGO  
        ENEENDO=UUEENDO+VVEENDO+PPEENDO+BBEENDO  
        ENEOUTO=UUEOUTO+VVEOUTO+PPEOUTO+BBEOUTO  
        VOLBMOO=VOLBEGO-VOLOUTO  
        SALBMOO=SALBEGO-SALOUTO  
        DYEBMOO=DYEBEGO-DYEOUTO  
        UMOBMOO=UMOBEGO-DYEOUTO  
        VMOBMOO=VMOBEGO-DYEOUTO  
        ENEBMOO=ENEBEGO-ENEOUTO  
        VOLERR=VOLENDO-VOLBMOO  
        SALERR=SALENDO-SALBMOO  
        DYEERR=DYEENDO-DYEBMOO  
        UMOERR=UMOENDO-UMOBMOO  
        VMOERR=VMOENDO-VMOBMOO  
        ENEERR=ENEENDO-ENEBMOO  
        RVERDE=-9999.  
        RSERDE=-9999.  
        RDERDE=-9999.  
        RUERDE=-9999.  
        RVERDE=-9999.  
        REERDE=-9999.  
        RVERDO=-9999.  
        RSERDO=-9999.  
        RDERDO=-9999.  
        RUERDO=-9999.  
        RVERDO=-9999.  
        REERDO=-9999.  
        IF(VOLENDO.NE.0.) RVERDE=VOLERR/VOLENDO  
        IF(SALENDO.NE.0.) RSERDE=SALERR/SALENDO  
        IF(DYEENDO.NE.0.) RDERDE=DYEERR/DYEENDO  
        IF(UMOENDO.NE.0.) RUMERDE=UMOERR/UMOENDO  
        IF(VMOENDO.NE.0.) RVMERDE=VMOERR/VMOENDO  
        IF(ENEENDO.NE.0.) REERDE=ENEERR/ENEENDO  
        IF(VOLOUTO.NE.0.) RVERDO=VOLERR/VOLOUTO  
        IF(SALOUTO.NE.0.) RSERDO=SALERR/SALOUTO  
        IF(DYEOUTO.NE.0.) RDERDO=DYEERR/DYEOUTO  
        IF(UMOOUTO.NE.0.) RUMERDO=UMOERR/UMOOUTO  
        IF(VMOOUTO.NE.0.) RVMERDO=VMOERR/VMOOUTO  
        IF(ENEOUTO.NE.0.) REERDO=ENEERR/ENEOUTO  
C  
C **  OUTPUT BALANCE RESULTS TO FILE BALO.OUT  
C  
        IF(JSBALO.EQ.1)THEN  
          OPEN(89,FILE='BALO.OUT',STATUS='UNKNOWN')  
          CLOSE(89,STATUS='DELETE')  
          OPEN(89,FILE='BALO.OUT',STATUS='UNKNOWN')  
          JSBALO=0  
        ELSE  
          OPEN(89,FILE='BALO.OUT',POSITION='APPEND',STATUS='UNKNOWN')  
        ENDIF  
        WRITE(89,890)NTMPD2,N  
        WRITE(89,891)  
        WRITE(89,892)VOLBEGO,SALBEGO,DYEBEGO,ENEBEGO,UMOBEGO,VMOBEGO  
     &      ,AMOBEGO  
        WRITE(89,900)  
        WRITE(89,893)  
        WRITE(89,892)VOLOUTO,SALOUTO,DYEOUTO,ENEOUTO,UMOOUTO,VMOOUTO  
        WRITE(89,900)  
        WRITE(89,894)  
        WRITE(89,892)VOLBMOO,SALBMOO,DYEBMOO,ENEBMOO,UMOBMOO,VMOBMOO  
        WRITE(89,900)  
        WRITE(89,895)  
        WRITE(89,892)VOLENDO,SALENDO,DYEENDO,ENEENDO,UMOENDO,VMOENDO  
     &      ,AMOENDO  
        WRITE(89,900)  
        WRITE(89,896)  
        WRITE(89,892)VOLERR,SALERR,DYEERR,ENEERR,UMOERR,VMOERR  
        WRITE(89,900)  
        WRITE(89,897)  
        WRITE(89,892)RVERDE,RSERDE,RDERDE,REERDE,RUMERDE,RVMERDE  
        WRITE(89,900)  
        WRITE(89,898)  
        WRITE(89,892)RVERDO,RSERDO,RDERDO,REERDO,RUMERDO,RVMERDO  
        WRITE(89,899)  
        UUEBMOO=UUEBEGO-UUEOUTO  
        VVEBMOO=VVEBEGO-VVEOUTO  
        PPEBMOO=PPEBEGO-PPEOUTO  
        BBEBMOO=BBEBEGO-BBEOUTO  
        WRITE(89,901)UUEBEGO  
        WRITE(89,902)UUEOUTO  
        WRITE(89,903)UUEBMOO  
        WRITE(89,904)UUEENDO  
        WRITE(89,900)  
        WRITE(89,905)VVEBEGO  
        WRITE(89,906)VVEOUTO  
        WRITE(89,907)VVEBMOO  
        WRITE(89,908)VVEENDO  
        WRITE(89,900)  
        WRITE(89,909)PPEBEGO  
        WRITE(89,910)PPEOUTO  
        WRITE(89,911)PPEBMOO  
        WRITE(89,912)PPEENDO  
        WRITE(89,900)  
        WRITE(89,913)BBEBEGO  
        WRITE(89,914)BBEOUTO  
        WRITE(89,915)BBEBMOO  
        WRITE(89,916)BBEENDO  
        WRITE(89,900)  
        WRITE(89,899)  
        CLOSE(89)  
  890 FORMAT (' VOLUME, MASS, AND ENERGY BALANCE OVER',I5,' TIME STEPS'  
     &    ,' ENDING AT TIME STEP',I5,//)  
  891 FORMAT (' INITIAL VOLUME    INITIAL SALT    INITIAL DYE     '  
     &    ,'INITIAL ENER    INITIAL UMO     INITIAL VMO     '  
     &    ,'INITIAL AMO',/)  
  892 FORMAT (1X,7(E14.6,2X))  
  893 FORMAT (' VOLUME OUT        SALT OUT        DYE OUT         '  
     &    ,'ENERGY OUT      UMO OUT         VMO OUT',/)  
  894 FORMAT (' INITIAL-OUT VOL   INIT-OUT SALT   INIT-OUT DYE    '  
     &    ,'INIT-OUT ENER   INIT-OUT UMO    INIT-OUT VMO',/)  
  895 FORMAT (' FINAL VOLUME      FINAL SALT      FINAL DYE       '  
     &    ,'FINAL ENERGY    FINAL UMO       FINAL VMO       '  
     &    ,'FINAL AMO',/)  
  896 FORMAT (' VOLUME ERR        SALT ERR        DYE ERR         '  
     &    ,'ENERGY ERR      UMO ERR         VMO ERR',/)  
  897 FORMAT (' R VOL/END ER      R SAL/END ER    R DYE/END ER    '  
     &    ,'R ENE/END ER    R UMO/END ER    R VMO/END ER',/)  
  898 FORMAT (' R VOL/OUT ER      R SAL/OUT ER    R DYE/OUT ER    '  
     &    ,'R ENE/OUT ER    R UMO/OUT ER    R VMO/OUT ER',/)  
  899 FORMAT (////)  
  900 FORMAT (//)  
  901 FORMAT(' UUEBEGO =  ',E14.6)  
  902 FORMAT(' UUEOUTO =  ',E14.6)  
  903 FORMAT(' UUEBMOO =  ',E14.6)  
  904 FORMAT(' UUEENDO =  ',E14.6)  
  905 FORMAT(' VVEBEGO =  ',E14.6)  
  906 FORMAT(' VVEOUTO =  ',E14.6)  
  907 FORMAT(' VVEBMOO =  ',E14.6)  
  908 FORMAT(' VVEENDO =  ',E14.6)  
  909 FORMAT(' PPEBEGO =  ',E14.6)  
  910 FORMAT(' PPEOUTO =  ',E14.6)  
  911 FORMAT(' PPEBMOO =  ',E14.6)  
  912 FORMAT(' PPEENDO =  ',E14.6)  
  913 FORMAT(' BBEBEGO =  ',E14.6)  
  914 FORMAT(' BBEOUTO =  ',E14.6)  
  915 FORMAT(' BBEBMOO =  ',E14.6)  
  916 FORMAT(' BBEENDO =  ',E14.6)  
        NBALO=0  
      ENDIF  
      NBALO=NBALO+1  
      RETURN  
      END  

