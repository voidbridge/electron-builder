!ifdef RUN_AFTER_FINISH
  !ifndef BUILD_UNINSTALLER
    !include StdUtils.nsh
    Function StartApp
      !ifdef INSTALL_MODE_PER_ALL_USERS
        ${StdUtils.ExecShellAsUser} $0 "$SMPROGRAMS\${PRODUCT_FILENAME}.lnk" "open" ""
      !else
        ${GetParameters} $R0
        ${GetOptions} $R0 "--update" $R1
        ${IfNot} ${Errors}
          ExecShell "" "$SMPROGRAMS\${PRODUCT_FILENAME}.lnk" "--updated"
        ${Else}
          ExecShell "" "$SMPROGRAMS\${PRODUCT_FILENAME}.lnk"
        ${endif}
      !endif
    FunctionEnd
  !endif
!endif


!ifdef LICENSE_FILE

  Function licensePre
      ${GetParameters} $R0
      ${GetOptions} $R0 "--update" $R1
      ${IfNot} ${Errors}
        Abort
      ${endif}
  FunctionEnd

  !define MUI_PAGE_CUSTOMFUNCTION_PRE licensePre
  !insertmacro MUI_PAGE_LICENSE "${LICENSE_FILE}"
!endif

!define MUI_PAGE_HEADER_TEXT "$(INSTALL_HEADER_TITLE)"
!define MUI_PAGE_HEADER_SUBTEXT "$(INSTALL_HEADER_SUBTITLE)"
!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT "$(INSTALL_FINISH_TITLE)"
!define MUI_INSTFILESPAGE_FINISHHEADER_SUBTEXT "$(INSTALL_FINISH_SUBTITLE)"
#!define MUI_INSTFILESPAGE_ABORTHEADER_TEXT "$(INSTALL_ABORT_TITLE)"
#!define MUI_INSTFILESPAGE_ABORTHEADER_SUBTEXT "$(INSTALL_ABORT_SUBTITLE)"
!insertmacro MUI_PAGE_INSTFILES

!ifdef BUILD_UNINSTALLER
  !define MUI_PAGE_HEADER_TEXT "$(UNINSTALL_HEADER_TITLE)"
  !define MUI_PAGE_HEADER_SUBTEXT "$(UNINSTALL_HEADER_SUBTITLE)"
  !define MUI_INSTFILESPAGE_FINISHHEADER_TEXT "$(UNINSTALL_FINISH_TITLE)"
  !define MUI_INSTFILESPAGE_FINISHHEADER_SUBTEXT "$(UNINSTALL_FINISH_SUBTITLE)"
#  !define MUI_INSTFILESPAGE_ABORTHEADER_TEXT "$(UNINSTALL_ABORT_TITLE)"
#  !define MUI_INSTFILESPAGE_ABORTHEADER_SUBTEXT "$(UNINSTALL_ABORT_SUBTITLE)"
  !insertmacro MUI_UNPAGE_INSTFILES
!endif

!insertmacro MUI_LANGUAGE "English"

!macro initMultiUser
  !ifdef INSTALL_MODE_PER_ALL_USERS
    !insertmacro setInstallModePerAllUsers
  !else
    !insertmacro setInstallModePerUser
  !endif
!macroend