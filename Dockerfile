# Python 3.10 Alpine 이미지를 기반으로 사용
FROM python:3.10-alpine

ENV PYTHONUNBUFFERED=1

WORKDIR /app

# 빌드 시 필요한 패키지 설치 (예: gcc, musl-dev)
RUN apk update && apk add --no-cache gcc musl-dev linux-headers

# requirements.txt 복사 후 의존성 설치
COPY requirements.txt /app/
RUN pip install --upgrade pip --root-user-action=ignore && pip install -r requirements.txt

# 프로젝트 전체 복사
COPY . /app/

# 정적 파일 수집
RUN python manage.py collectstatic --noinput

EXPOSE 8000

# gunicorn으로 앱 실행 (모듈 방식으로 실행)
CMD ["python", "-m", "gunicorn", "src.wsgi:application", "--bind", "0.0.0.0:8000"]
