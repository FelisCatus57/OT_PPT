from django.contrib import admin
from django.urls import path
from .views import home  # 방금 만든 뷰를 import

urlpatterns = [
    path('', home, name='home'),  # 루트 경로에 home 뷰 연결
    path('admin/', admin.site.urls),  # admin 페이지는 그대로 유지
]
