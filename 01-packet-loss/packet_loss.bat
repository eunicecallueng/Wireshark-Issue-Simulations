@echo off
:: Open Clumsy (replace with your actual folder path)
start "" "C:\YourFolder\clumsy.exe"

:: Open Wireshark
start "" "C:\Program Files\Wireshark\Wireshark.exe"

:: Start generating the ping traffic
ping 1.1.1.1 -t