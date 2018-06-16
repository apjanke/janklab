classdef uuid < jl.util.Displayable
    %UUID An example UUID implementation using planar codegen
    %
    % Examples:
    %
    
    % @planarprecedence(hiBits, loBits)
    
    properties
        hiBits uint64 % @planar
        loBits uint64 % @planar
        isNaN  logical = true % @planar @planarnanflag
    end
    
    methods
        function this = uuid(varargin)
        %UUID Construct a new uuid
        %
        % uuid()
        % uuid(str)   % str may be char or cellstr
        % uuid(juuid)  % a java.util.UUID
        % uuid(hiBits, loBits)
        % uuid(hiBits, loBits, isNaN)
        if nargin == 0
            return
        elseif nargin == 1
            if isa(varargin{1}, 'java.util.UUID')
                juuid = varargin{1};
                this.hiBits = typecast(juuid.getMostSignificantBits(), 'uint64');
                this.loBits = typecast(juuid.getLeastSignificantBits(), 'uint64');
                this.isNaN = false;
            else
                strs = cellstr(varargin{1});
                this = repmat(this, size(strs));
                for i = 1:numel(strs)
                    if isempty(strs{i})
                        this.isNaN(i) = true;
                    else
                        juuid = java.util.UUID.fromString(strs{i});
                        this.hiBits(i) = typecast(juuid.getMostSignificantBits(), 'uint64');
                        this.loBits(i) = typecast(juuid.getLeastSignificantBits(), 'uint64');
                        this.isNaN(i) = false;
                    end
                end
            end
        else
            this.hiBits = varargin{1};
            this.loBits = varargin{2};
            if nargin >= 3
                this.isNaN = varargin{3};
            end
        end
        end
        
        function out = dispstrs(this)
        out = cell(size(this));
        for i = 1:numel(this)
            if this.isNaN(i)
                out{i} = 'NaN';
            else
                juuid = java.util.UUID(typecast(this.hiBits, 'int64'), ...
                    typecast(this.loBits, 'int64'));
                out{i} = char(juuid.toString());
            end
        end
        end
        
    end
    
    methods (Static)
        function out = random(n)
        %RANDOM Create a random UUID
        if nargin < 1 || isempty(n); n = 1; end
        out = repmat(jl.code.uuid, [n 1]);
        for i = 1:n
            juuid = java.util.UUID.randomUUID;
            out(i) = jl.code.uuid(juuid);
        end
        end
    end
    
    
    %%%%% START PLANAR-CLASS BOILERPLATE CODE %%%%%
    
    % This section contains code auto-generated by Janklab's genPlanarClass.
    % Do not edit code in this section manually.
    % Do not remove the "%%%%% START/END .... %%%%%" header or footer either;
    % that will cause the code regeneration to break.
    % To update this code, re-run jl.code.genPlanarClass() on this file.
    
    methods
    
        function out = size(this)
        %SIZE Size of array.
        out = size(this.hiBits);
        end
        
        function out = numel(this)
        %NUMEL Number of elements in array.
        out = numel(this.hiBits);
        end
        
        function out = ndims(this)
        %NDIMS Number of dimensions.
        out = ndims(this.hiBits);
        end
        
        function out = isempty(this)
        %ISEMPTY True for empty array.
        out = isempty(this.hiBits);
        end
        
        function out = isscalar(this)
        %ISSCALAR True if input is scalar.
        out = isscalar(this.hiBits);
        end
        
        function out = isvector(this)
        %ISVECTOR True if input is a vector.
        out = isvector(this.hiBits);
        end
        
        function out = iscolumn(this)
        %ISCOLUMN True if input is a column vector.
        out = iscolumn(this.hiBits);
        end
        
        function out = isrow(this)
        %ISROW True if input is a row vector.
        out = isrow(this.hiBits);
        end
        
        function out = ismatrix(this)
        %ISMATRIX True if input is a matrix.
        out = ismatrix(this.hiBits);
        end
        
        function out = isnan(this)
        %ISNAN True for Not-a-Number.
        out = isnan2(this.hiBits) ...
                | isnan2(this.loBits);
        out(this.isNaN) = true;
        end
        
        function this = reshape(this, varargin)
        %RESHAPE Reshape array.
        this.hiBits = reshape(this.hiBits, varargin{:});
        this.loBits = reshape(this.loBits, varargin{:});
        this.isNaN = reshape(this.isNaN, varargin{:});
        end
        
        function this = squeeze(this, varargin)
        %SQUEEZE Remove singleton dimensions.
        this.hiBits = squeeze(this.hiBits, varargin{:});
        this.loBits = squeeze(this.loBits, varargin{:});
        this.isNaN = squeeze(this.isNaN, varargin{:});
        end
        
        function this = circshift(this, varargin)
        %CIRCSHIFT Shift positions of elements circularly.
        this.hiBits = circshift(this.hiBits, varargin{:});
        this.loBits = circshift(this.loBits, varargin{:});
        this.isNaN = circshift(this.isNaN, varargin{:});
        end
        
        function this = permute(this, varargin)
        %PERMUTE Permute array dimensions.
        this.hiBits = permute(this.hiBits, varargin{:});
        this.loBits = permute(this.loBits, varargin{:});
        this.isNaN = permute(this.isNaN, varargin{:});
        end
        
        function this = ipermute(this, varargin)
        %IPERMUTE Inverse permute array dimensions.
        this.hiBits = ipermute(this.hiBits, varargin{:});
        this.loBits = ipermute(this.loBits, varargin{:});
        this.isNaN = ipermute(this.isNaN, varargin{:});
        end
        
        function this = repmat(this, varargin)
        %REPMAT Replicate and tile array.
        this.hiBits = repmat(this.hiBits, varargin{:});
        this.loBits = repmat(this.loBits, varargin{:});
        this.isNaN = repmat(this.isNaN, varargin{:});
        end
        
        function this = ctranspose(this, varargin)
        %CTRANSPOSE Complex conjugate transpose.
        this.hiBits = ctranspose(this.hiBits, varargin{:});
        this.loBits = ctranspose(this.loBits, varargin{:});
        this.isNaN = ctranspose(this.isNaN, varargin{:});
        end
        
        function this = transpose(this, varargin)
        %TRANSPOSE Transpose vector or matrix.
        this.hiBits = transpose(this.hiBits, varargin{:});
        this.loBits = transpose(this.loBits, varargin{:});
        this.isNaN = transpose(this.isNaN, varargin{:});
        end
        
        function [this, nshifts] = shiftdim(this, n)
        %SHIFTDIM Shift dimensions.
        if nargin > 1
            this.hiBits = shiftdim(this.hiBits, n);
            this.loBits = shiftdim(this.loBits, n);
            this.isNaN = shiftdim(this.isNaN, n);
        else
            this.hiBits = shiftdim(this.hiBits);
            this.loBits = shiftdim(this.loBits);
            [this.isNaN,nshifts] = shiftdim(this.isNaN);
        end
        end
        
        function out = cat(dim, varargin)
        %CAT Concatenate arrays.
        args = varargin;
        for i = 1:numel(args)
            if ~isa(args{i}, 'jl.code.uuid')
                args{i} = jl.code.uuid(args{i});
            end
        end
        out = args{1};
        fieldArgs = cellfun(@(obj) obj.hiBits, args, 'UniformOutput', false);
        out.hiBits = cat(dim, fieldArgs{:});
        fieldArgs = cellfun(@(obj) obj.loBits, args, 'UniformOutput', false);
        out.loBits = cat(dim, fieldArgs{:});
        fieldArgs = cellfun(@(obj) obj.isNaN, args, 'UniformOutput', false);
        out.isNaN = cat(dim, fieldArgs{:});
        end
        
        function out = horzcat(varargin)
        %HORZCAT Horizontal concatenation.
        out = cat(2, varargin{:});
        end
        
        function out = vertcat(varargin)
        %VERTCAT Vertical concatenation.
        out = cat(1, varargin{:});
        end
        
        function this = subsasgn(this, s, b)
        %SUBSASGN Subscripted assignment.
        
        % Chained subscripts
        if numel(s) > 1
            rhs_in = subsref(this, s(1));
            rhs = subsasgn(rhs_in, s(2:end), b);
        else
            rhs = b;
        end
        
        % Base case
        switch s(1).type
            case '()'
                this = subsasgnParensPlanar(this, s(1), rhs);
            case '{}'
                error('jl:BadOperation',...
                    '{}-subscripting is not supported for class %s', class(this));
            case '.'
                this.(s(1).subs) = rhs;
        end
        end
        
        function out = subsref(this, s)
        %SUBSREF Subscripted reference.
        
        % Base case
        switch s(1).type
            case '()'
                out = subsrefParensPlanar(this, s(1));
            case '{}'
                error('jl:BadOperation',...
                    '{}-subscripting is not supported for class %s', class(this));
            case '.'
                out = this.(s(1).subs);
        end
        
        % Chained reference
        if numel(s) > 1
            out = subsref(out, s(2:end));
        end
        end
        
        function n = numArgumentsFromSubscript(this,~,indexingContext) %#ok<INUSL>
        switch indexingContext
            case matlab.mixin.util.IndexingContext.Statement
                n = 1; % nargout for indexed reference used as statement
            case matlab.mixin.util.IndexingContext.Expression
                n = 1; % nargout for indexed reference used as function argument
            case matlab.mixin.util.IndexingContext.Assignment
                n = 1; % nargin for indexed assignment
        end
        end
        
        function out = eq(a, b)
        %EQ == Equal.
        if ~isa(a, 'jl.code.uuid')
            a = jl.code.uuid(a);
        end
        if ~isa(b, 'jl.code.uuid')
            b = jl.code.uuid(b);
        end
        tf = a.hiBits == b.hiBits;
        tf(tf) = a.loBits(tf) == b.loBits(tf);
        out = tf;
        out(a.isNaN | b.isNaN) = false;
        end
        
        function out = lt(a, b)
        %LT < Less than.
        if ~isa(a, 'jl.code.uuid')
            a = jl.code.uuid(a);
        end
        if ~isa(b, 'jl.code.uuid')
            b = jl.code.uuid(b);
        end
        out = false(size(a));
        tfUndecided = true(size(out));
        % Check field hiBits
        lhs = a.hiBits(tfUndecided);
        rhs = b.hiBits(tfUndecided);
        tfThisStep = lhs < rhs;
        out(tfUndecided) = tfThisStep;
        tfUndecided(tfUndecided) = ~tfThisStep & ~isnan(lhs) & ~isnan(rhs);
        % Check field loBits
        lhs = a.loBits(tfUndecided);
        rhs = b.loBits(tfUndecided);
        tfThisStep = lhs < rhs;
        out(tfUndecided) = tfThisStep;
        % Check NaN flags
        out(a.isNaN | b.isNaN) = false;
        end
        
        function out = gt(a, b)
        %GT > Greater than.
        if ~isa(a, 'jl.code.uuid')
            a = jl.code.uuid(a);
        end
        if ~isa(b, 'jl.code.uuid')
            b = jl.code.uuid(b);
        end
        out = false(size(a));
        tfUndecided = true(size(out));
        % Check field hiBits
        lhs = a.hiBits(tfUndecided);
        rhs = b.hiBits(tfUndecided);
        tfThisStep = lhs > rhs;
        out(tfUndecided) = tfThisStep;
        tfUndecided(tfUndecided) = ~tfThisStep & ~isnan(lhs) & ~isnan(rhs);
        % Check field loBits
        lhs = a.loBits(tfUndecided);
        rhs = b.loBits(tfUndecided);
        tfThisStep = lhs > rhs;
        out(tfUndecided) = tfThisStep;
        % Check NaN flags
        out(a.isNaN | b.isNaN) = false;
        end
        
        function out = ne(a, b)
        %NE ~= Not equal.
        out = ~(a == b);
        end
        
        function out = le(a, b)
        %LE <= Less than or equal.
        out = a < b | a == b;
        end
        
        function out = ge(a, b)
        %GE <= Greater than or equal.
        out = a > b | a == b;
        end
        
        function out = cmp(a, b)
        %CMP Compare values for ordering.
        %
        % CMP compares values elementwise, returning for each element:
        %   -1 if a(i) < b(i)
        %   0  if a(i) == b(i)
        %   1  if a(i) > b(i)
        %   NaN if either a(i) or b(i) were NaN, or no relop methods returned
        %       true
        %
        % Returns an array the same size as a and b (after scalar expansion).
        
        if ~isa(a, 'jl.code.uuid')
            a = jl.code.uuid(a);
        end
        if ~isa(b, 'jl.code.uuid')
            b = jl.code.uuid(b);
        end
        out = NaN(size(a));
        tfUndecided = true(size(out));
        % Test <
        tf = a < b;
        out(tf) = -1;
        tfUndecided(tf) = false;
        % Test ==
        tf = a(tfUndecided) == b(tfUndecided);
        nextTest = NaN(size(tf));
        nextTest(tf) = 0;
        out(tfUndecided) = nextTest;
        tfUndecided(tfUndecided) = ~tf;
        % Test >
        tf = a(tfUndecided) > b(tfUndecided);
        nextTest = NaN(size(tf));
        nextTest(tf) = 1;
        out(tfUndecided) = nextTest;
        tfUndecided(tfUndecided) = ~tf; %#ok<NASGU>
        % Anything left over is either NaN inputs or an unsupported relop
        end
        
        function [keysA,keysB] = proxyKeys(a, b)
        %PROXYKEYS Proxy key values for sorting and set operations
        
        propertyValsA = {a.hiBits a.loBits a.isNaN};
        propertyTypesA = cellfun(@class, propertyValsA, 'UniformOutput',false);
        isAllNumericA = all(cellfun(@isnumeric, propertyValsA));
        propertyValsA = cellfun(@(x) x(:), propertyValsA, 'UniformOutput',false);
        if nargin == 1
            if isAllNumericA && isscalar(unique(propertyTypesA))
                % Properties are homogeneous numeric types; we can use them directly 
                keysA = cat(2, propertyValsA{:});
            else
                % Properties are heterogeneous or non-numeric; resort to using a table
                propertyNames = {'hiBits' 'loBits' 'isNaN'};
                keysA = table(propertyValsA{:}, 'VariableNames', propertyNames);
            end
        else
            propertyValsB = {b.hiBits b.loBits b.isNaN};
            propertyTypesB = cellfun(@class, propertyValsB, 'UniformOutput',false);
            isAllNumericB = all(cellfun(@isnumeric, propertyValsB));
            propertyValsB = cellfun(@(x) x(:), propertyValsB, 'UniformOutput',false);
            if isAllNumericA && isAllNumericB && isscalar(unique(propertyTypesA)) ...
                && isscalar(unique(propertyTypesB))
                % Properties are homogeneous numeric types; we can use them directly
                keysA = cat(2, propertyValsA{:});
                keysB = cat(2, propertyValsB{:});
            else
                % Properties are heterogeneous or non-numeric; resort to using a table
                propertyNames = {'hiBits' 'loBits' 'isNaN'};
                keysA = table(propertyValsA{:}, 'VariableNames', propertyNames);
                keysB = table(propertyValsB{:}, 'VariableNames', propertyNames);
            end
        end
        end
    
    end
    
    methods (Access=private)
    
        function this = subsasgnParensPlanar(this, s, rhs)
        %SUBSASGNPARENSPLANAR ()-assignment for planar object
        if ~isa(rhs, 'jl.code.uuid')
            rhs = jl.code.uuid(rhs);
        end
        this.hiBits(s.subs{:}) = rhs.hiBits;
        this.loBits(s.subs{:}) = rhs.loBits;
        this.isNaN(s.subs{:}) = rhs.isNaN;
        end
        
        function out = subsrefParensPlanar(this, s)
        %SUBSREFPARENSPLANAR ()-indexing for planar object
        out = this;
        out.hiBits = this.hiBits(s.subs{:});
        out.loBits = this.loBits(s.subs{:});
        out.isNaN = this.isNaN(s.subs{:});
        end
        
        function out = parensRef(this, ix)
        %PARENSREF ()-indexing, for this class's internal use
        out = subsrefParensPlanar(this, struct('subs', {{ix}}));
        end
    
    end
    
    %%%%% END PLANAR-CLASS BOILERPLATE CODE %%%%%

    
    
    
end



%%%%% START PLANAR-CLASS BOILERPLATE LOCAL FUNCTIONS %%%%%

% This section contains code auto-generated by Janklab's genPlanarClass.
% Do not edit code in this section manually.
% Do not remove the "%%%%% START/END .... %%%%%" header or footer either;
% that will cause the code regeneration to break.
% To update this code, re-run jl.code.genPlanarClass() on this file.

function out = isnan2(x)
%ISNAN2 True if input is NaN or NaT
% This is a hack to work around the edge case of @datetime, which 
% defines an isnat() function instead of supporting isnan() like 
% everything else.
if isa(x, 'datetime')
    out = isnat(x);
else
    out = isnan(x);
end
end

%%%%% END PLANAR-CLASS BOILERPLATE LOCAL FUNCTIONS %%%%%
