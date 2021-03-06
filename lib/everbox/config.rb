EVERBOX_DEBUG = 1 # 0 => production, 1 => development

EVERBOX_FILE_CHUNK_SIZE = 4194304 # 4*1024*1024 = 4M
EVERBOX_SMALL_FILE_SIZE = 4096 # 4*1024 = 4K

EVERBOX_OK = 200 # success
EVERBOX_PARTIAL_OK = 298 # success(partially)
EVERBOX_PARTIAL_CONTENT = 206
EVERBOX_NOOP = 299 # noop
EVERBOX_NOT_MODIFIED = 304
EVERBOX_BAD_REQUEST = 400
EVERBOX_OUT_OF_SPACE = 402
EVERBOX_FORBIDDEN = 403
EVERBOX_EOF = 404
EVERBOX_CONFLICTED = 409
EVERBOX_INVALIDARGS = 499
EVERBOX_NOTIMPL = 501
EVERBOX_INVALIDRET = -1
EVERBOX_BUFFER_LIMITED = -3
EVERBOX_IO_ERROR = -4

EVERBOX_FILE = 1
EVERBOX_DIR = 2
EVERBOX_DELETED = 0X8000

# define service interface
if EVERBOX_DEBUG == 0 # production
  EVERBOX_DOMAIN = '.everbox.com/'
  EVERBOX_ACCOUNT_SERVER = 'http://account' + EVERBOX_DOMAIN
else # development
  EVERBOX_DOMAIN = '.everbox.net/'
  EVERBOX_ACCOUNT_SERVER = 'http://acc' + EVERBOX_DOMAIN
end

EVERBOX_FS_SERVER = 'http://fs' + EVERBOX_DOMAIN # mock-fs | fs | fs-https
EVERBOX_LOG_SERVER = 'http://log' + EVERBOX_DOMAIN
EVERBOX_BIZ_SERVER = 'http://biz' + EVERBOX_DOMAIN

# HTTP: GET /login?user=<UserName>&passwd=<Password>[&devId=<DevId>]
# RETURN(JSON):
#     200 OK {token:"<Token>"}
#     403 Forbidden {error:"BadAuthentication"}
EVERBOX_ACCOUNT_LOGIN = EVERBOX_ACCOUNT_SERVER  + 'login'
EVERBOX_ACCOUNT_LOGIN_FMT = EVERBOX_ACCOUNT_LOGIN + '?user=%s&passwd=%s&devId=%s'

# HTTP: GET /logout?token=<Token>
# RETURN:
#     200 OK
EVERBOX_ACCOUNT_LOGOUT = EVERBOX_ACCOUNT_SERVER + 'logout'
EVERBOX_ACCOUNT_LOGOUT_FMT = EVERBOX_ACCOUNT_LOGOUT + '?token=%s'

# define log interface
EVERBOX_LOG = EVERBOX_LOG_SERVER
EVERBOX_LOG_FMT = EVERBOX_LOG + '?token=%s'

# define fs interface
EVERBOX_FS_SEARCH = EVERBOX_FS_SERVER + 'search'
EVERBOX_FS_MKDIR = EVERBOX_FS_SERVER + 'mkdir'
EVERBOX_FS_GET = EVERBOX_FS_SERVER + 'get'
EVERBOX_FS_PREPARE_PUT = EVERBOX_FS_SERVER + 'prepare_put'
EVERBOX_FS_COMMIT_PUT = EVERBOX_FS_SERVER + 'commit_put'
EVERBOX_FS_MOVE = EVERBOX_FS_SERVER + 'move'
EVERBOX_FS_COPY = EVERBOX_FS_SERVER + 'copy'
EVERBOX_FS_DELETE = EVERBOX_FS_SERVER + 'delete'
EVERBOX_FS_UNDELETE = EVERBOX_FS_SERVER + 'undelete'
EVERBOX_FS_PURGE = EVERBOX_FS_SERVER + 'purge'
EVERBOX_FS_INFO = EVERBOX_FS_SERVER + 'info'
EVERBOX_FS_CHECK = EVERBOX_FS_SERVER + 'check'

# define device interface
EVERBOX_DEVICE_SET = EVERBOX_BIZ_SERVER + 'device/set'
EVERBOX_DEVICE_LIST = EVERBOX_BIZ_SERVER + 'device/list'
EVERBOX_DEVICE_UNLINK = EVERBOX_BIZ_SERVER + 'device/unlink'
EVERBOX_DEVICE_LOSE = EVERBOX_BIZ_SERVER + 'device/lose'
