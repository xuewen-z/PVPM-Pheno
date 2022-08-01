function TLAI=SLAI2TLAI(SLAI,kLeaf,DateDims)

% using the time-stepping method to derive leaf area index
% from steady state leaf area index  to derive

% permute to put dates as the first column
if numel(kLeaf) >1
    if size(kLeaf) ~= size(SLAI)
        error('kLeaf must have the same size with SLAI');
    end
    kLeaf = shiftdata(kLeaf,DateDims);
end

[SLAI,Perm,Nshift] = shiftdata(SLAI,DateDims);

% find date numbers
MatSize=size(SLAI);
if MatSize(1) ~= 365
    warning(['Dates are not 365 but ',num2str(MatSize(1))]);
end

% reshape matrix
if numel(MatSize)==3
    SLAI = reshape(SLAI,MatSize(1),[]);
    kLeaf= reshape(kLeaf,MatSize(1),[]);
end

% process to derive leaf area index
TLAI=SLAI;
if numel(kLeaf) >1
    for Date=2:MatSize(1)
        TLAI(Date,:)=TLAI(Date-1,:) + kLeaf(Date-1,:) .* (SLAI(Date-1,:)- TLAI(Date-1,:));
    end
else
    for Date=2:MatSize(1)
        TLAI(Date,:)=TLAI(Date-1,:) + kLeaf .* (SLAI(Date-1,:)- TLAI(Date-1,:));
    end    
end

% reshape matrix back
if numel(MatSize)==3
    TLAI = reshape(TLAI,MatSize(1),MatSize(2),[]);
end

% permute matrix back
TLAI = unshiftdata(TLAI,Perm,Nshift);

end
