function b = subsref(frf,s)
%SUBSREF subscripted indexing
%
%  val=SUBSREF(f, subs) allows access to mwlfixedrecordfile object
%  properties using the object.property syntax.
%


%  Copyright 2005-2006 Fabian Kloosterman

switch s(1).type
 case '.'
  fields = get(frf, 'fields');
  if ~isempty(fields) && any( strcmp(s(1).subs, name(fields) ) ) %load data
    if numel(s)==1
      b = load( frf, s(1).subs );
    elseif strcmp( s(2).type, '()' )
      b = load( frf, s(1).subs, s(2).subs{:});
    end
    b = b.(s(1).subs);
  elseif ~isempty(fields) && any( strcmp( strrep( s(1).subs, '_', ' '), name(fields) ) )
    %if field name contains spaces (which are replaced by underscores)
    if numel(s)==1
      b = load( frf, strrep( s(1).subs, '_',  ' ') );
    elseif strcmp( s(2).type, '()' )
      b = load( frf, strrep( s(1).subs, '_', ' '), s(2).subs{:});
    end
    b = b.(s(1).subs);
  elseif strcmp(s(1).subs, 'nrecords')
    b = get(frf, 'nrecords');
  elseif strcmp(s(1).subs, 'recordsize')
    b = frf.recordsize;
  else
    b = subsref(frf.mwlrecordfilebase, s);
  end
end