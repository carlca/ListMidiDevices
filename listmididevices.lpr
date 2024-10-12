program ListMIDIDevices;

uses
  SysUtils, Classes,
  {$IFDEF DARWIN}
  {$LINKFRAMEWORK CoreMIDI}
  MacOsAll,
  CocoaAll;
  {$ENDIF}
  {$IFDEF WINDOWS}
  Windows,
  MMSystem;
  {$ENDIF}

procedure db(s: string);
begin
  WriteLn(s);
end;

procedure ListMIDIDevices;
var
  numDevs, i: Integer;
  midiOutCaps: TMidiOutCaps;
  midiInCaps: TMidiInCaps;
begin
  // List MIDI Output Devices
  numDevs := midiOutGetNumDevs;
  Writeln('MIDI Output Devices:');
  for i := 0 to numDevs - 1 do
  begin
    if midiOutGetDevCaps(i, @midiOutCaps, SizeOf(midiOutCaps)) = MMSYSERR_NOERROR then
    begin
      Writeln(Format('Device %d: %s', [i, midiOutCaps.szPname]));
    end
    else
    begin
      Writeln(Format('Device %d: Error retrieving device information', [i]));
    end;
  end;

  // List MIDI Input Devices
  numDevs := midiInGetNumDevs;
  Writeln('MIDI Input Devices:');
  for i := 0 to numDevs - 1 do
  begin
    if midiInGetDevCaps(i, @midiInCaps, SizeOf(midiInCaps)) = MMSYSERR_NOERROR then
    begin
      Writeln(Format('Device %d: %s', [i, midiInCaps.szPname]));
    end
    else
    begin
      Writeln(Format('Device %d: Error retrieving device information', [i]));
    end;
  end;
end;

begin
  try
    ListMIDIDevices;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
