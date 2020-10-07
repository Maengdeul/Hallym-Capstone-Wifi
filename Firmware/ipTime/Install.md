<ipTime A8004T 공유기 기준 OpenWrt 설치 방법>
  1. 공유기 설치
  2. 192.168.0.1 접속
  3. 내부 ip를 192.168.1.1로 변경
  4. OpenWrt 공식 사이트에서 ipTime A8004T의 Firmware OpenWrt snapshot Install URL을 통해 해당 파일 다운로드
  5. 192.168.0.1에서 펌웨어 업데이트 페이지로 이동
  6. 수동 업그레이드 체크
  7. OpenWrt 공식 사이트에서 다운로드 받은 파일(~kernel.bin)을 선택 후 업그레이드
  8. OpenWrt 공식 사이트에서 ipTime A8004T의 Firmware OpenWrt snapshot Upgrade URL을 복사
  9. 원격 접속 프로그램(PowerShell, PuTTy 등) 실행 후 ssh root@192.168.1.1로 접속
 10. wget <복사한 URL> 입력
 11. opkg update
 12. opkg install luci
