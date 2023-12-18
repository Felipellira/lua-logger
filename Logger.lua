Logger = {}

Logger.loggerLevels = {
  TRACE = 10,
  DEBUG = 20,
  INFO = 30,
  WARN = 40,
  ERROR = 50,
  FATAL = 60
}

function Logger:new(loggerLevel, moduleName)

  if not loggerLevel then
    loggerLevel = self.loggerLevels.INFO
  end

  if not moduleName then
    moduleName = "Unknown"
  end

  local instance = {
    loggerLevel = loggerLevel,
    moduleName = moduleName,
    loggerLevelNames = {}
  }

  setmetatable(instance, self)
  self.__index = self

  instance:_generateLogLevelNames()

  return instance
end

function Logger:_generateLogLevelNames()
  for name, level in pairs(self.loggerLevels) do
    self.loggerLevelNames[level] = name
  end
end

function Logger:_generateLogMessage(level, message)
  local date
  if IsDuplicityVersion() then
    date = os.date('%Y-%m-%d %H:%M:%S')
  else
    local year, month, day, hour, minute, second = GetLocalTime()
    print(year, month, day, hour, minute, second)
    date = string.format("%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second)
  end
  local levelName = self.loggerLevelNames[level]
  local logMessage = string.format("%s [%s] [%s] %s", date, levelName, self.moduleName, message)
  return logMessage
end

function Logger:_log(level, message)
  if level >= self.loggerLevel then
    local logMessage = self:_generateLogMessage(level, message)
    print(logMessage)
  end
end

function Logger:trace(message)
  self:_log(self.loggerLevels.TRACE, message)
end

function Logger:debug(message)
  self:_log(self.loggerLevels.DEBUG, message)
end

function Logger:info(message)
  self:_log(self.loggerLevels.INFO, message)
end

function Logger:warn(message)
  self:_log(self.loggerLevels.WARN, message)
end

function Logger:error(message)
  self:_log(self.loggerLevels.ERROR, message)
end

function Logger:fatal(message)
  self:_log(self.loggerLevels.FATAL, message)
end

return Logger
