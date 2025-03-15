### Folder Name Conventions

1. widgets : 화면마다 사용되는 위젯이 아닌, 주로 공통적으로 사용되는 위젯을 모아두는 폴더 이름
2. screens : 공통 위젯이 아닌, 화면 단위를 구성하는 모든것을 모아두는 폴더 이름. 주로 하위에 Activity나 ViewController에 해당하는 한 화면단위로 폴더를 더 만들어두는 것이 특징
3. blocs : BLoC 패턴 관련 폴더
4. streams : Stream 관련 폴더
5. provs : Provider 관련 폴더
6. assets : 외부 파일을 프로젝트에 포함시킬때 사용되는 폴더
7. i18n : 다국어 관련 파일이 담긴 폴더
8. models : 모델 관련 폴더
9. services : 싱글톤 패턴을 사용한 기능을 모아두는 폴더
10. utils : 잡다한 기능들을 위한 폴더
11. components : 컴포넌트들을 위한 폴더
12. theme : 색상, 스타일을 위한 폴더

### Lint

- prefer_const_constructors # const 생성자 사용 권장
- avoid_print # print 사용 금지
- always_use_package_imports # 패키지 임포트 사용 강제
- prefer_single_quotes # 작은따옴표 사용 권장
