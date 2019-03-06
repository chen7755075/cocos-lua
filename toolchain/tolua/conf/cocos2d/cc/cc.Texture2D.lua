local arr = {}

local cls = class()
cls.CPPCLS = "cocos2d::Texture2D::PixelFormat"
cls.LUACLS = "cc.Texture2D.PixelFormat"
cls.enum('AUTO', 'cocos2d::Texture2D::PixelFormat::AUTO')
cls.enum('BGRA8888', 'cocos2d::Texture2D::PixelFormat::BGRA8888')
cls.enum('RGBA8888', 'cocos2d::Texture2D::PixelFormat::RGBA8888')
cls.enum('RGB888', 'cocos2d::Texture2D::PixelFormat::RGB888')
cls.enum('RGB565', 'cocos2d::Texture2D::PixelFormat::RGB565')
cls.enum('A8', 'cocos2d::Texture2D::PixelFormat::A8')
cls.enum('I8', 'cocos2d::Texture2D::PixelFormat::I8')
cls.enum('AI88', 'cocos2d::Texture2D::PixelFormat::AI88')
cls.enum('RGBA4444', 'cocos2d::Texture2D::PixelFormat::RGBA4444')
cls.enum('RGB5A1', 'cocos2d::Texture2D::PixelFormat::RGB5A1')
cls.enum('PVRTC4', 'cocos2d::Texture2D::PixelFormat::PVRTC4')
cls.enum('PVRTC4A', 'cocos2d::Texture2D::PixelFormat::PVRTC4A')
cls.enum('PVRTC2', 'cocos2d::Texture2D::PixelFormat::PVRTC2')
cls.enum('PVRTC2A', 'cocos2d::Texture2D::PixelFormat::PVRTC2A')
cls.enum('ETC', 'cocos2d::Texture2D::PixelFormat::ETC')
cls.enum('S3TC_DXT1', 'cocos2d::Texture2D::PixelFormat::S3TC_DXT1')
cls.enum('S3TC_DXT3', 'cocos2d::Texture2D::PixelFormat::S3TC_DXT3')
cls.enum('S3TC_DXT5', 'cocos2d::Texture2D::PixelFormat::S3TC_DXT5')
cls.enum('ATC_RGB', 'cocos2d::Texture2D::PixelFormat::ATC_RGB')
cls.enum('ATC_EXPLICIT_ALPHA', 'cocos2d::Texture2D::PixelFormat::ATC_EXPLICIT_ALPHA')
cls.enum('ATC_INTERPOLATED_ALPHA', 'cocos2d::Texture2D::PixelFormat::ATC_INTERPOLATED_ALPHA')
cls.enum('DEFAULT', 'cocos2d::Texture2D::PixelFormat::AUTO')
arr[#arr + 1] = cls

local cls = class()
cls.CPPCLS = "cocos2d::Texture2D"
cls.LUACLS = "cc.Texture2D"
cls.SUPERCLS = "cc.Ref"
cls.prop('defaultAlphaPixelFormat', 'static Texture2D::PixelFormat getDefaultAlphaPixelFormat()', 'static void setDefaultAlphaPixelFormat(Texture2D::PixelFormat format)')
cls.prop('description', 'std::string getDescription()')
cls.prop('pixelFormat', 'Texture2D::PixelFormat getPixelFormat()')
cls.prop('pixelsWide', 'int getPixelsWide()')
cls.prop('pixelsHigh', 'int getPixelsHigh()')
cls.prop('name', 'GLuint getName()')
cls.prop('maxS', 'GLfloat getMaxS()', 'void setMaxS(GLfloat maxS)')
cls.prop('maxT', 'GLfloat getMaxT()', 'void setMaxT(GLfloat maxT)')
cls.prop('glProgram', 'GLProgram* getGLProgram()', 'void setGLProgram(GLProgram* program)')
cls.prop('path', 'std::string getPath()')
cls.prop('alphaTexture', 'Texture2D* getAlphaTexture()', 'void setAlphaTexture(Texture2D* alphaTexture)')
cls.prop('alphaTextureName', 'GLuint getAlphaTextureName()')
cls.func(nil, 'void releaseGLTexture()')
cls.func(nil, 'bool initWithImage(Image * image)', 'bool initWithImage(Image * image, PixelFormat format)')
cls.func(nil, 'void setTexParameters(const TexParams& texParams)')
cls.func(nil, 'void setAntiAliasTexParameters()')
cls.func(nil, 'void setAliasTexParameters()')
cls.func(nil, 'void generateMipmap()')
cls.func(nil, 'unsigned int getBitsPerPixelForFormat()', 'unsigned int getBitsPerPixelForFormat(Texture2D::PixelFormat format)')
cls.func(nil, 'const char* getStringForFormat()')
cls.func(nil, 'unpack const Size& getContentSizeInPixels()')
cls.func(nil, 'bool hasPremultipliedAlpha()')
cls.func(nil, 'bool hasMipmaps()')
cls.func(nil, 'unpack Size getContentSize()')
arr[#arr + 1] = cls

return arr