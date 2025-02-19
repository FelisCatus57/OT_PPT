FROM python:3.10-alpine

ENV PYTHONUNBUFFERED=1
WORKDIR /app

RUN apk update && apk add --no-cache gcc musl-dev linux-headers

COPY requirements.txt /app/
RUN pip install --upgrade pip --root-user-action=ignore && pip install -r requirements.txt

# 비-root 사용자 생성 및 전환
RUN adduser -D myuser
USER myuser

COPY . /app/

EXPOSE 8000
CMD ["gunicorn", "src.wsgi:application", "--bind", "0.0.0.0:8000"]
