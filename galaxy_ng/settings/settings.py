CONTENT_ORIGIN = "http://localhost:8080"
ANSIBLE_API_HOSTNAME = "http://localhost:8080"
GALAXY_COLLECTION_SIGNING_SERVICE = None
ALLOWED_EXPORT_PATHS = ["/tmp"]
ALLOWED_IMPORT_PATHS = ["/tmp"]

GALAXY_REQUIRE_CONTENT_APPROVAL = False
GALAXY_AUTHENTICATION_CLASSES = [
    "rest_framework.authentication.SessionAuthentication",
    "rest_framework.authentication.BasicAuthentication",
]

GALAXY_REQUIRE_SIGNATURE_FOR_APPROVAL = False

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'pulp',
        'USER': 'pulp',
        'PASSWORD': 'pulp',
        'HOST': 'localhost',
        'PORT': '',
    }
}

REDIS_HOST = 'localhost'
REDIS_PORT = 6379
REDIS_PASSWORD = ''