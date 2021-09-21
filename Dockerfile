FROM ubuntu:20.04

COPY . /appl/rest-api-example/

# Ensure apt is in non-interactive to avoid prompts
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update  \
  && apt-get -y install --no-install-recommends python3.9-minimal python3-pip \
  && pip3 --disable-pip-version-check --no-cache-dir \
      install -r /appl/rest-api-example/requirements.txt \
  && apt-get autoremove -y && apt-get clean -y  \
  && rm -rf /var/lib/apt/lists/*  \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base 

ENTRYPOINT ["python3","/appl/rest-api-example/main.py"]

EXPOSE 5000 8080 80 443

# docker build . -t rest-api-example -f Dockerfile
# docker build . --no-cache -t rest-api-example -f Dockerfile
# docker run -p 80:5000 rest-api-example
# docker tag rest-api-example kolisachint/rest-api-example
# docker push kolisachint/rest-api-example
