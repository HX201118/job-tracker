# -*- coding: utf-8 -*-
"""
求职投递管理器 - 本地服务启动脚本
用途：以 http://localhost 方式打开 job-tracker.html，
      这样浏览器才允许弹出「系统通知」（直接双击 html 的 file:// 方式会被浏览器禁用）。
用法：双击「启动-系统通知版.bat」，或在此目录执行  python serve.py
"""
import http.server
import socketserver
import webbrowser
import os
import sys

PORT = 8765
PAGE = "job-tracker.html"


def main():
    # 切到脚本所在目录，保证能找到 job-tracker.html
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    # 端口被占用时自动往后找一个可用端口
    port = PORT
    for _ in range(20):
        try:
            httpd = socketserver.TCPServer(("127.0.0.1", port), http.server.SimpleHTTPRequestHandler)
            break
        except OSError:
            port += 1
    else:
        print("无法找到可用端口，请关闭占用 8765-8785 的程序后重试。")
        input("按回车退出...")
        return

    url = "http://127.0.0.1:%d/%s" % (port, PAGE)
    print("=" * 56)
    print(" 求职投递管理器 已启动")
    print(" 访问地址: %s" % url)
    print(" 请在这个页面里点「开启桌面提醒」授权，即可收到系统通知")
    print(" 关闭本窗口（或按 Ctrl+C）即停止服务，数据不受影响")
    print("=" * 56)
    try:
        webbrowser.open(url)
    except Exception:
        pass
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n已停止服务。")
    finally:
        httpd.server_close()


if __name__ == "__main__":
    main()
