FROM tobix/pywine
MAINTAINER Dominic Davis-Foster "dominic@davis-foster.co.uk"

ARG BUILD_DATE
ARG VCS_REF

LABEL \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.name="The NIST Library Conversion program running in Wine and Docker" \
  org.label-schema.vcs-url="https://github.com/domdfcoding/lib2nist-wine"

COPY requirements.txt /requirements.txt
COPY make_nistlib.sh /make_nistlib.sh
RUN chmod +x /make_nistlib.sh

# Download and unzip Lib2Nist
RUN apt-get update && \
	apt-get install wget -y &&\
	wget https://chemdata.nist.gov/mass-spc/ms-search/downloads/LIB2NIST.zip
RUN unzip LIB2NIST.zip -d /LIB2NIST

# Make input and output dirs
RUN mkdir /input && mkdir /output

ENV PYTHONUNBUFFERED=1
