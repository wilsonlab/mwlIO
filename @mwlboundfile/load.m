function cb = load(bf, cid)
%LOAD

fid = fopen( fullfile(bf), 'r');

if fid == -1
    error('Cannot open file')
end

if nargin<2
    cid = -1;
end

%fseek to header offset
fseek(fid, get(bf, 'headersize'), -1);

cb = struct('nbounds', {}, 'bounds', {});

while ( ~feof(fid) )
    
    lin = fgetl(fid);
    
    if ~isempty(deblank(lin))
        
        cluster_id = str2num(lin);
        
        if length(cb)<1
            cb(cluster_id).bounds = struct('projections', {}, 'projection_names', {}, 'vertices', {});
        end
        if cluster_id>length(cb) || isempty(cb(cluster_id).nbounds)
            cb(cluster_id).nbounds = 1;
        else
            cb(cluster_id).nbounds = cb(cluster_id).nbounds + 1;
        end
        
        [cb(cluster_id).bounds(end+1).projections, np] = sscanf( fgetl(fid), '%d' );
        
        cb(cluster_id).bounds(end).projection_names = textscan(fid, '%s', np, 'Delimiter', ' ');
        
        ncoord = fscanf(fid, '%d', 1);
        
        cb(cluster_id).bounds(end).vertices = fscanf(fid, '%f', [ncoord 2]);
        
    end
    
end

if cid>0
    cb = cb(cid);
end
    