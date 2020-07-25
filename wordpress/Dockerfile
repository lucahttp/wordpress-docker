# Dockerfile
FROM python:3.7
RUN pip install bottle mysql-connector-python
COPY ./test.py /opt/
EXPOSE 8080
CMD ["python3", "/opt/test.py"]