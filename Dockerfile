FROM intersystemsdc/irishealth-community:2021.1.0.215.3-zpm

# create /app
USER root
RUN mkdir /app && chown $ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP /app

USER ${ISC_PACKAGE_MGRUSER}

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP irissession.sh /
RUN chmod +x /irissession.sh

# copy source code
WORKDIR /app 
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP install /app/install

SHELL ["/irissession.sh"]

RUN \
  zn "USER" \
  # install webterminal
  zpm "install webterminal" \
  # install demo
  do $SYSTEM.OBJ.LoadDir("/app/install/HL7", "ck", ,1) \
  do $SYSTEM.OBJ.LoadDir("/app/install/Loan", "ck", ,1) \
  do $system.OBJ.Load("/app/install/Loan/latest/csp/app/DemoLoanForm.csp", "ck") \
  do $system.OBJ.Load("/app/install/Loan/latest/csp/app/DemoLoanSubmit.csp", "ck") \  
  set sc = 1
  
# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
CMD [ "-l", "/usr/irissys/mgr/messages.log" ]