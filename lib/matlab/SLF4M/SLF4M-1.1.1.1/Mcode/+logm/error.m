function error(msg, varargin)
% Log an ERROR level message from caller, with printf style formatting.
%
% logm.error(msg, varargin)
% logm.error(exception, msg, varargin)
%
% This accepts a message with printf style formatting, using '%...' formatting
% controls as placeholders.
%
% Examples:
%
% logm.error('Some message. value1=%s value2=%d', 'foo', 42);

loggerCallImpl('error', msg, varargin);

end