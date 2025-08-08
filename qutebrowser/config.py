config.load_autoconfig()

c.confirm_quit = ['downloads']
c.auto_save.session = False
c.content.autoplay = False
c.content.geolocation = False
c.content.headers.accept_language = 'en-GB,en;q=0.5'
c.content.cookies.accept = 'no-3rdparty'
c.content.dns_prefetch = False
c.content.headers.do_not_track = True
c.content.headers.referer = 'same-domain'
c.content.headers.user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36'

c.colors.webpage.darkmode.enabled = True
