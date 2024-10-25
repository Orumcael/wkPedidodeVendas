unit db_connection;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Def, System.SysUtils, IniFiles, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TDBConnection = class
  private
    FConnection: TFDConnection;
  public
    constructor Create;
    function GetConnection: TFDConnection;
  end;

implementation

constructor TDBConnection.Create;
var
  ini: TIniFile;
  host, port, user, password, database, charset, dllpath, appPath: string;
begin
  appPath := ExtractFilePath(ParamStr(0)); // Pega o caminho da aplicacao atual
  appPath := StringReplace(appPath, 'Win32\Debug\', 'resources\config.ini', []);

  ini := TIniFile.Create(appPath);

  try
    host := ini.ReadString('database', 'host', '');
    port := ini.ReadString('database', 'port', '');
    user := ini.ReadString('database', 'user', '');
    password := ini.ReadString('database', 'password', '');
    database := ini.ReadString('database', 'database', '');
    charset := ini.ReadString('database', 'charset', '');
    dllpath := ini.ReadString('database', 'dllpath', '');

    FConnection := TFDConnection.Create(nil);

    FConnection.Params.Values['DriverID'] := 'MySQL';     // Identificador do driver
    FConnection.Params.Values['Server'] := host;          // Nome do servidor
    FConnection.Params.Values['Database'] := database;    // Nome do banco de dados
    FConnection.Params.Values['User_Name'] := user;       // Nome do usuario
    FConnection.Params.Values['Password'] := password;    // Senha do usuario
    FConnection.Params.Values['Port'] := port;            // Porta padrao do MySQL
    FConnection.Params.Values['CharacterSet'] := charset; // Definir o charset, se necessario
    FConnection.Params.Values['VendorLib'] := dllpath;    // Biblioteca cliente do MySQL

    FConnection.Connected := True;
  finally
    ini.Free;
  end;
end;

function TDBConnection.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

end.
