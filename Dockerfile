# Python 3.10 Alpine 이미지를 기반으로 사용 (아주 가벼움)
FROM python:3.10-alpine

# Python 출력 버퍼링 해제
ENV PYTHONUNBUFFERED=1

# 작업 디렉토리 설정
WORKDIR /app

# 빌드 시 필요한 C 컴파일러 등 설치 (Django, gunicorn 등의 설치에 필요할 수 있음)
RUN apk update && apk add --no-cache gcc musl-dev linux-headers

# 의존성 파일 복사 후 설치 (프로젝트 루트에 requirements.txt 파일이 있어야 함)
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# 프로젝트 전체 복사
COPY . /app/

# 컨테이너 포트 노출
EXPOSE 8000

# Gunicorn으로 앱 실행 (src.wsgi:application)
CMD ["gunicorn", "src.wsgi:application", "--bind", "0.0.0.0:8000"]
