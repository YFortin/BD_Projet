FROM python:3.7-slim

WORKDIR /app
ADD requirements.txt .
RUN pip install -r requirements.txt
ADD . .
RUN echo "============"
RUN ls -a
RUN echo "============"

ENTRYPOINT ["python"]
CMD ["app.py"]