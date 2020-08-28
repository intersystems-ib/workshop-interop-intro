FROM store/intersystems/irishealth-community:2020.2.0.211.0

# create /app
USER root
RUN mkdir /app && chown $ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP /app

USER ${ISC_PACKAGE_MGRUSER}

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP irissession.sh /
RUN chmod +x /irissession.sh

# copy source code
WORKDIR /app 
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP install /app/install

# download zpm
RUN mkdir -p /app/deps \
 && cd /app/deps \
 && wget -q https://pm.community.intersystems.com/packages/zpm/latest/installer -O zpm.xml

SHELL ["/irissession.sh"]

RUN \
  # install zpm + webterminal
  zn "USER" \
  do $system.OBJ.Load("/app/deps/zpm.xml", "ck") \
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