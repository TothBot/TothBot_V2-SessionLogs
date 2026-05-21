LOG=/home/tothbot/logs/tothbot.log
echo '===SERVICE==='
systemctl status tothbot --no-pager | head -10
echo
echo '===EVENT COUNTS==='
for evt in RECONNECT_INITIATED RECONNECT_COMPLETE RECONNECT_ATTEMPT_FAILED RECONNECT_TRIGGERED FATAL_RECONNECT_FAILURE WS_MGR_FATAL ALERT_SMTP_FAILED PAPER_BALANCE_SET; do
  printf '%-35s %s\n' "$evt:" "$(grep -c "\"event\":\"$evt\"" $LOG)"
done
echo
echo '===LAST 3 FATAL_RECONNECT_FAILURE==='
grep '"event":"FATAL_RECONNECT_FAILURE"' $LOG | tail -3
echo
echo '===LAST 20 RECONNECT_ATTEMPT_FAILED ERRORS==='
grep '"event":"RECONNECT_ATTEMPT_FAILED"' $LOG | tail -20 | grep -oE '"error":"[^"]*"'
echo
echo '===LAST 3 RECONNECT_COMPLETE (if any)==='
grep '"event":"RECONNECT_COMPLETE"' $LOG | tail -3
echo
echo '===PAPER MODE CONFIRM==='
grep '"event":"PAPER_BALANCE_SET"' $LOG | tail -2