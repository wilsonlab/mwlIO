function test_mwlio()

filename = tempname

%create new header
hdr = header( newheader( 'TestDate', datestr(now) ) );

%create data
data.scalar = [1:100];
data.vector = [1 2 3]' * [1:100];
fcn = @(x,y, xc, yc, alpha, scale) cos( ( (x-xc).*cos(pi/3+alpha) + (y-yc).*sin(pi/3+alpha) )./scale ) + cos( ( (x-xc).*cos(alpha) + (y-yc).*sin(alpha) )./scale ) + cos( ( (x-xc).*cos(-pi/3+alpha) + (y-yc).*sin(-pi/3+alpha) )./scale );
x = repmat( linspace(-4*pi, 4*pi, 20 ), 20, 1 );

offset_x = 2.*circ_unifrnd( 100,1 );
offset_y = 2.*circ_unifrnd( 100,1 );
rotation = circ_unifrnd( 100,1 );

for k=1:100
    data.matrix(1:20,1:20,k) = fcn(x', x, offset_x(k), offset_y(k), rotation(k),1 );
end

%create fields
flds = mwlfield( {'scalar', 'vector', 'matrix'}, {'short', 'short', 'double'}, {[1], [3], [20 20]} );

%create mwlfixedrecordfile
f = mwlcreate( filename, 'fixedrecord', 'Fields', flds, 'Header', hdr, 'Mode', 'overwrite', 'Data', data);

clear f;

%open file
f = mwlopen( filename );

%read data
newdata = load( f )
newdata = loadField(f, 'matrix');


%create mwlfixedrecordfile (ascii)
f = mwlcreate( filename, 'fixedrecord', 'Fields', flds, 'Header', hdr, 'Mode', 'overwrite', 'Data', data, 'FileFormat', 'ascii');

clear f;

%open file
f = mwlopen( filename );

%read data
newdata = load( f )
newdata = loadField(f, 'matrix');

delete(filename);