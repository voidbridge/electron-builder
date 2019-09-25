!macro downloadApplicationFiles
  Var /GLOBAL packageUrl
  Var /GLOBAL packageArch

  StrCpy $packageUrl "${APP_PACKAGE_URL}"
  StrCpy $packageArch "${APP_PACKAGE_URL}"

  !ifdef APP_PACKAGE_URL_IS_INCOMLETE
    !ifdef APP_64_NAME
      !ifdef APP_32_NAME
        ${if} ${RunningX64}
          StrCpy $packageUrl "$packageUrl/${APP_64_NAME}"
        ${else}
          StrCpy $packageUrl "$packageUrl/${APP_32_NAME}"
        ${endif}
      !else
        StrCpy $packageUrl "$packageUrl/${APP_64_NAME}"
      !endif
    !else
      StrCpy $packageUrl "$packageUrl/${APP_32_NAME}"
    !endif
  !endif

  ${if} ${RunningX64}
    StrCpy $packageArch "64"
  ${else}
    StrCpy $packageArch "32"
  ${endif}

  !ifdef APP_PACKAGE_HEADER_HOST
    !define CUSTOM_HEADER_HOST '/HEADER "Host: ${APP_PACKAGE_HEADER_HOST}"'
  !else
    !define CUSTOM_HEADER_HOST ''
  !endif

  !define FLAGS '/POPUP "package.7z" /NOCANCEL'
  !define I18N '/CAPTION "$(DOWNLOAD_CAPTION)" /RESUME "$(DOWNLOAD_RESUME)" /TRANSLATE "$(DOWNLOAD_URL)" "$(DOWNLOAD_DOWNLOADING)" "$(DOWNLOAD_CONNECTING)" "$(DOWNLOAD_FILE_NAME)" "$(DOWNLOAD_RECEIVED)" "$(DOWNLOAD_FILE_SIZE)" "$(DOWNLOAD_REMAINING_TIME)" "$(DOWNLOAD_TOTAL_TIME)"'

  download:
  inetc::get ${FLAGS} ${I18N} /USERAGENT "electron-builder (Mozilla)" /header "X-Arch: $packageArch" ${CUSTOM_HEADER_HOST} /RESUME "" "$packageUrl" "$PLUGINSDIR\package.7z" /END
  Pop $0
  ${if} $0 == "Cancelled"
    quit
  ${elseif} $0 != "OK"
    Messagebox MB_RETRYCANCEL|MB_ICONEXCLAMATION "$(DOWNLOAD_ERROR) (status: $0)." IDRETRY download
    Quit
  ${endif}

  StrCpy $packageFile "$PLUGINSDIR\package.7z"
!macroend