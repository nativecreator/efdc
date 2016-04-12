C
C**********************************************************************C
C**********************************************************************C
C**********************************************************************C
C
      SUBROUTINE INITBIN2
C
C**********************************************************************C
C
C M.R. MORTON    01 APR 1999
C
C **  LAST MODIFIED BY JOHN HAMRICK AND MIKE MORTON ON 8 AUGUST 2001
C
C **  THIS SUBROUTINE IS PART OF  EFDC-FULL VERSION 1.0a 
C
C **  LAST MODIFIED BY JOHN HAMRICK ON 1 NOVEMBER 2001
C
C----------------------------------------------------------------------C
C
C CHANGE RECORD
C DATE MODIFIED     BY                 DATE APPROVED    BY
C
C----------------------------------------------------------------------C
C
C
C**********************************************************************C
C
C INITIALIZES BINARY FILE FOR EFDC OUTPUT.  PLACES CONTROL
C PARAMETERS FOR POST-PROCESSOR IN HEADER SECTION OF BINARY
C FILE WQDIURDO.BIN FOR DIURNAL DISSOLVED OXYGEN CALCULATIONS.
C
C**********************************************************************C
C
C
      USE GLOBAL
C
      REAL,SAVE,ALLOCATABLE,DIMENSION(:)::XLON  
      REAL,SAVE,ALLOCATABLE,DIMENSION(:)::YLAT  
C
      PARAMETER(MXPARM=30)
      REAL TEND
C
      INTEGER NPARM, NCELLS
      LOGICAL FEXIST
      CHARACTER*20 WQNAME(MXPARM)
      CHARACTER*10 WQUNITS(MXPARM)
      CHARACTER*3  WQCODE(MXPARM)
C
      IF(.NOT.ALLOCATED(XLON))THEN
		ALLOCATE(XLON(LCM))
		ALLOCATE(YLAT(LCM))
	    XLON=0.0 
	    YLAT=0.0 
	ENDIF
C
C THE FOLLOWING PARAMETERS ARE SPECIFIED IN EFDC.INP AND WQ3DWC.INP:
C KC       = NUMBER OF VERTICAL LAYERS
C IWQDIUDT = NUMBER OF TIME STEPS PER DATA DUMP
C DT       = TIME STEP OF EFDC MODEL IN SECONDS
C LA       = NUMBER OF ACTIVE CELLS + 1 IN MODEL
C TBEGAN   = BEGINNING TIME OF RUN IN DAYS
C
C THE PARAMETER NPARM MUST BE CHANGED IF THE OUTPUT DATA
C IS CHANGED IN SUBROUTINE WWQTSBIN:
C NPARM   = NUMBER OF PARAMETERS WRITTEN TO BINARY FILE
C
C NREC2   = NUMBER OF RECORDS WRITTEN TO BINARY FILE (ONE RECORD
C           IS A COMPLETE DATA DUMP FOR TIME INTERVAL IWQDIUDT)
C
      NPARM = 20
      NCELLS = LA-1
      NREC2 = 0
      TEND = TBEGIN
      MAXRECL2 = 32
      IF(NPARM .GE. 8)THEN
        MAXRECL2 = NPARM*4
      ENDIF
C
C THE FOLLOWING WATER QUALITY NAMES, UNITS, AND 3-CHARACTER CODES
C SHOULD BE MODIFIED TO MATCH THE PARAMETERS WRITTEN TO THE BINARY
C FILE IN SUBROUTINE WWQTSBIN.  THE CHARACTER STRINGS MUST BE
C EXACTLY THE LENGTH SPECIFIED BELOW IN ORDER FOR THE POST-PROCESSOR
C TO WORK CORRECTLY.
C
C BE SURE WQNAME STRINGS ARE EXACTLY 20-CHARACTERS LONG:
C------------------'         1         2'
C------------------'12345678901234567890'
      WQNAME( 1) = 'SALINITY            '
      WQNAME( 2) = 'TEMPERATURE         '
      WQNAME( 3) = 'DO_SATURATION       '
      WQNAME( 4) = 'DISSOLVED_OXYGEN    '
      WQNAME( 5) = 'SED_OXYGEN_DEMAND   '
      WQNAME( 6) = 'KA_REAERATION       '
      WQNAME( 7) = 'LAYER_THICKNESS     '
      WQNAME( 8) = 'PRIM_PRODUCTION_CYA '
      WQNAME( 9) = 'RESPIRATION_CYA     '
      WQNAME(10) = 'PRIM_PRODUCTION_DIA '
      WQNAME(11) = 'RESPIRATION_DIA     '
      WQNAME(12) = 'PRIM_PRODUCTION_GRN '
      WQNAME(13) = 'RESPIRATION_GRN     '
      WQNAME(14) = 'PRIM_PRODUCTION_MAC '
      WQNAME(15) = 'RESPIRATION_MAC     '
      WQNAME(16) = 'ALGAE_CYANOBACTERIA '
      WQNAME(17) = 'ALGAE_DIATOMS       '
      WQNAME(18) = 'ALGAE_GREENS        '
      WQNAME(19) = 'TOTAL_CHLOROPHYLLA  '
      WQNAME(20) = 'MACROALGAE          '
C
C BE SURE WQUNITS STRINGS ARE EXACTLY 10-CHARACTERS LONG:
C-------------------'         1'
C-------------------'1234567890'
      WQUNITS( 1) = 'G/L       '
      WQUNITS( 2) = 'DEGC      '
      WQUNITS( 3) = 'MG/L      '
      WQUNITS( 4) = 'MG/L      '
      WQUNITS( 5) = 'G/M2/DAY  '
      WQUNITS( 6) = 'PER_DAY   '
      WQUNITS( 7) = 'METERS    '
      WQUNITS( 8) = 'MGO2/L/DAY'
      WQUNITS( 9) = 'MGO2/L/DAY'
      WQUNITS(10) = 'MGO2/L/DAY'
      WQUNITS(11) = 'MGO2/L/DAY'
      WQUNITS(12) = 'MGO2/L/DAY'
      WQUNITS(13) = 'MGO2/L/DAY'
      WQUNITS(14) = 'MGO2/L/DAY'
      WQUNITS(15) = 'MGO2/L/DAY'
      WQUNITS(16) = 'UG/L      '
      WQUNITS(17) = 'UG/L      '
      WQUNITS(18) = 'UG/L      '
      WQUNITS(19) = 'UG/L      '
      WQUNITS(20) = 'UG/L      '
C
C BE SURE WQCODE STRINGS ARE EXACTLY 3-CHARACTERS LONG:
C
C------------------'123'
      WQCODE( 1) = 'SAL'
      WQCODE( 2) = 'TEM'
      WQCODE( 3) = 'DOS'
      WQCODE( 4) = 'DOO'
      WQCODE( 5) = 'SOD'
      WQCODE( 6) = 'RKA'
      WQCODE( 7) = 'DEP'
      WQCODE( 8) = 'PPC'
      WQCODE( 9) = 'RRC'
      WQCODE(10) = 'PPD'
      WQCODE(11) = 'RRD'
      WQCODE(12) = 'PPG'
      WQCODE(13) = 'RRG'
      WQCODE(14) = 'PPM'
      WQCODE(15) = 'RRM'
      WQCODE(16) = 'CYA'
      WQCODE(17) = 'DIA'
      WQCODE(18) = 'GRN'
      WQCODE(19) = 'CHL'
      WQCODE(20) = 'MAC'
C
C---------------------------------------------------------
C
C IF WQDIURDO.BIN ALREADY EXISTS, OPEN FOR APPENDING HERE.
C
      IF(ISDIURDO .EQ. 2)THEN
        INQUIRE(FILE='WQDIURDO.BIN', EXIST=FEXIST)
        IF(FEXIST)THEN
          OPEN(UNIT=2, FILE='WQDIURDO.BIN', ACCESS='DIRECT',
     +     FORM='UNFORMATTED', STATUS='UNKNOWN', RECL=MAXRECL2)
          WRITE(0,*) 'OLD FILE WQDIURDO.BIN FOUND...OPENING FOR APPEND'
          READ(2, REC=1) NREC2, TBEGAN, TEND, DT, IWQDIUDT, NPARM,
     +      NCELLS, KC
          NR4 = 1 + NPARM*3 + NCELLS*4 + (NCELLS*KC+1)*NREC2 + 1
          CLOSE(2)
        ELSE
          ISDIURDO=1
        ENDIF
      ENDIF
C
C-------------------------------------------------------------------
C
C IF WQDIURDO.BIN ALREADY EXISTS, DELETE IT HERE.
C
      IF(ISDIURDO .EQ. 1)THEN
        TBEGAN = TBEGIN
        INQUIRE(FILE='WQDIURDO.BIN', EXIST=FEXIST)
        IF(FEXIST)THEN
          OPEN(UNIT=2, FILE='WQDIURDO.BIN')
          CLOSE(UNIT=2, STATUS='DELETE')
          WRITE(0,*) 'OLD FILE WQDIURDO.BIN DELETED...'
        ENDIF

        OPEN(UNIT=2, FILE='WQDIURDO.BIN', ACCESS='DIRECT',
     +     FORM='UNFORMATTED', STATUS='UNKNOWN', RECL=MAXRECL2)
C--------------------------------------------------------------------
C WRITE CONTROL PARAMETERS FOR POST-PROCESSOR TO HEADER
C SECTION OF THE WQWCAVG.BIN BINARY FILE:
C
        WRITE(2) NREC2, TBEGAN, TEND, DT, IWQDIUDT, NPARM, NCELLS, KC
        DO I=1,NPARM
          WRITE(2) WQNAME(I)
        ENDDO
        DO I=1,NPARM
          WRITE(2) WQUNITS(I)
        ENDDO
        DO I=1,NPARM
          WRITE(2) WQCODE(I)
        ENDDO
C
C WRITE CELL I,J MAPPING REFERENCE TO HEADER SECTION OF BINARY FILE:
C
        DO L=2,LA
          WRITE(2) IL(L)
        ENDDO
        DO L=2,LA
          WRITE(2) JL(L)
        ENDDO
C
C **  READ IN XLON AND YLAT OR UTME AND UTMN OF CELL CENTERS OF
C **  CURVILINEAR PORTION OF THE GRID FROM FILE LXLY.INP:
C
        OPEN(1,FILE='LXLY.INP',STATUS='UNKNOWN')
C
        DO NS=1,4
          READ(1,1111)
        ENDDO
 1111   FORMAT(80X)
C
        DO LL=1,LVC
          READ(1,*) I,J,XUTME,YUTMN
          L=LIJ(I,J)
          XLON(L)=XUTME
          YLAT(L)=YUTMN
        ENDDO
        CLOSE(1)
C
C WRITE XLON AND YLAT OF CELL CENTERS TO HEADER SECTION OF
C BINARY OUTPUT FILE:
C
        DO L=2,LA
          WRITE(2) XLON(L)
        ENDDO
        DO L=2,LA
          WRITE(2) YLAT(L)
        ENDDO

        INQUIRE(UNIT=2, NEXTREC=NR4)
        CLOSE(2)
      ENDIF

      RETURN
      END
