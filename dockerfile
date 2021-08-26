FROM public.ecr.aws/lambda/python:3.9

ADD requirements.txt .
ADD app.py ${LAMBDA_TASK_ROOT}

RUN yum update -y \
    && curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo \
    && yum remove unixODBC-utf16 unixODBC-utf16-devel \
    && ACCEPT_EULA=Y yum install -y msodbcsql17  \
    && ACCEPT_EULA=Y yum install -y mssql-tools \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && source ~/.bashrc \
    && yum install -y unixODBC-devel \
    && yum install -y gcc-c++ \
    && yum clean all \
    && pip install --no-cache-dir --upgrade pip setuptools \ 
    && pip install --no-cache-dir -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

CMD ["app.handler"]
