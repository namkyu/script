#!/bin/sh

: '
    다음의 명령어에서 사용하는 정규표현식 설명
    - sed(Stream EDitor)
    - /s/RE/repl/g 와 같은 패턴으로 사용
    - 주어진 입력에 포함된 RE(Regular Expression)에 match되는 모든 문자열을 repl로 바꾼다.
    - RE에서 \( 와 \)로 감싸여진 부분은 Memory에 저장되어 repl을 기술할 때 \1, \2와 같이 사용할 수 있다.
'

# sed에서 사용하는 정규표현식은 title="{여기부분 추출}" 을 위함이다.
curl -s https://github.com/namkyu/script | grep "class=\"js-navigation-open\"" | sed "s/.* title=\"\(.*\)\".*/\1/"

echo "Done!!"