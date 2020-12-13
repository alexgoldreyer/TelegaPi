﻿unit TelegramBotApi.Client;

interface

uses
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request,
  CloudApi.IAuthenticator,
  CloudApi.Request,
  CloudApi.Client.Sync;

type
  TTelegramBotApi = class
  public const
    LIB_VERSION = '4.6.0.alpha';
  private
    FCloudApi: TCloudApiClient;
    FBotToken: string;
    FAutoFreeRequestArgument: Boolean;
    function GetBotToken: string;
    procedure SetBotToken(const Value: string);
  protected
    function InternalExecute<TArgument, TResult>(AArgument: TArgument): ItgResponse<TResult>; overload;
    function InternalExecute<TResult>(ARequest: IcaRequest): ItgResponse<TResult>; overload;
    function InternalExecuteCustom<TResult>(ARequest: IcaRequest): TResult; overload;
    function InternalExecuteCustom<TArgument: record; TResult>(AArgument: TArgument): TResult; overload;
  public
{$REGION 'Getting updates'}
    function GetUpdates(AGetUpdatesArgument: TtgGetUpdatesArgument): ItgResponse<TArray<TtgUpdate>>; overload;
    class function GetUpdates(const AJson: string): ItgResponse<TArray<TtgUpdate>>; overload;
    function SetWebhook(SetWebhookArgument: TtgSetWebhookArgument): Boolean;
    function DeleteWebhook(): Boolean;
    function GetWebhookInfo(): ItgResponse<TtgWebhookInfo>; overload;
{$ENDREGION}
{$REGION 'Available methods'}
    /// <summary>
    /// A simple method for testing your bot's auth token. Requires no parameters.
    /// Returns basic information about the bot in form of a User object.
    /// </summary>
    function GetMe: ItgResponse<TtgUser>;
    /// <summary>
    /// Use this method to log out from the cloud Bot API server before launching the
    /// bot locally. You must log out the bot before running it locally, otherwise
    /// there is no guarantee that the bot will receive updates. After a successful
    /// call, you can immediately log in on a local server, but will not be able to log
    /// in back to the cloud Bot API server for 10 minutes. Returns True on success.
    /// Requires no parameters.
    /// </summary>
    function LogOut: ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to close the bot instance before moving it from one local
    /// server to another. You need to delete the webhook before calling this method to
    /// ensure that the bot isn't launched again after server restart. The method will
    /// return error 429 in the first 10 minutes after the bot is launched. Returns
    /// True on success. Requires no parameters.
    /// </summary>
    function Close: ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to send text messages. On success, the sent Message is returned.
    /// </summary>
    function SendMessage(ASendMessageArgument: TtgMessageArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to forward messages of any kind. On success, the sent Message
    /// is returned.
    /// </summary>
    function ForwardMessage(AForwardMessageArgument: TtgForwardMessageArgument): ItgResponse<TtgMessage>;
    /// <summary> Use this method to copy messages of any kind. The method is analogous
    /// to the method forwardMessages, but the copied message doesn't have a link to
    /// the original message. Returns the MessageId of the sent message on success.
    /// </summary>
    function CopyMessage(ACopyMessageArgument: TtgCopyMessageArgument): ItgResponse<Int64>;
    /// <summary>
    /// Use this method to send photos. On success, the sent Message is returned.
    /// </summary>
    function SendPhoto(ASendPhotoArgument: TtgSendPhotoArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to display
    /// them in the music player. Your audio must be in the .MP3 or .M4A format. On
    /// success, the sent Message is returned. Bots can currently send audio files of
    /// up to 50 MB in size, this limit may be changed in the future.
    ///
    /// For sending voice messages, use the sendVoice method instead.
    /// </summary>
    function SendAudio(ASendAudioArgument: TtgSendAudioArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send general files. On success, the sent Message is returned.
    /// Bots can currently send files of any type of up to 50 MB in size, this limit
    /// may be changed in the future.
    /// </summary>
    function SendDocument(ASendDocumentArgument: TtgSendDocumentArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send video files, Telegram clients support mp4 videos (other
    /// formats may be sent as Document). On success, the sent Message is returned.
    /// Bots can currently send video files of up to 50 MB in size, this limit may be
    /// changed in the future.
    /// </summary>
    function SendVideo(ASendVideoArgument: TtgSendVideoArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without
    /// sound). On success, the sent Message is returned. Bots can currently send
    /// animation files of up to 50 MB in size, this limit may be changed in the future.
    /// </summary>
    function SendAnimation(ASendAnimationArgument: TtgSendAnimationArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to display
    /// the file as a playable voice message. For this to work, your audio must be in
    /// an .OGG file encoded with OPUS (other formats may be sent as Audio or Document).
    /// On success, the sent Message is returned. Bots can currently send voice
    /// messages of up to 50 MB in size, this limit may be changed in the future.
    /// </summary>
    function SendVoice(ASendVoiceArgument: TtgSendVoiceArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// As of v.4.0, Telegram clients support rounded square mp4 videos of up to 1
    /// minute long. Use this method to send video messages. On success, the sent
    /// Message is returned.
    /// </summary>
    function SendVideoNote(ASendVideoNoteArgument: TtgSendVideoNoteArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send a group of photos or videos as an album. On success, an
    /// array of the sent Messages is returned.
    /// </summary>
    function SendMediaGroup(ASendMediaGroupArgument: TtgSendMediaGroupArgument): ItgResponse<TArray<TtgMessage>>;
    /// <summary>
    /// Use this method to send point on the map. On success, the sent Message is
    /// returned.
    /// </summary>
    /// <returns> :ItgResponse<TtgMessage>
    /// </returns>
    function SendLocation(ASendLocationArgument: TtgSendLocationArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to edit live location messages. A location can be edited until
    /// its live_period expires or editing is explicitly disabled by a call to
    /// stopMessageLiveLocation. On success, if the edited message was sent by the bot,
    /// the edited Message is returned, otherwise True is returned.
    /// </summary>
    function EditMessageLiveLocation(AEditMessageLiveLocationArgument
      : TtgEditMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>; overload;
    /// <summary>
    /// Use this method to edit live location messages. A location can be edited until
    /// its live_period expires or editing is explicitly disabled by a call to
    /// stopMessageLiveLocation. On success, if the edited message was sent by the bot,
    /// the edited Message is returned, otherwise True is returned.
    /// </summary>
    function EditMessageLiveLocation(AEditMessageLiveLocationArgument: TtgEditMessageLiveLocationArgument)
      : ItgResponse<TtgMessage>; overload;
    /// <summary> Use this method to stop updating a live location message before
    /// live_period expires. On success, if the message was sent by the bot, the sent
    /// Message is returned, otherwise True is returned.</summary>
    function StopMessageLiveLocation(AEditMessageLiveLocationArgument
      : TtgStopMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>; overload;
    /// <summary> Use this method to stop updating a live location message before
    /// live_period expires. On success, if the message was sent by the bot, the sent
    /// Message is returned, otherwise True is returned.</summary>
    function StopMessageLiveLocation(AEditMessageLiveLocationArgument: TtgStopMessageLiveLocationArgument)
      : ItgResponse<TtgMessage>; overload;
    /// <summary>
    /// Use this method to send information about a venue. On success, the sent Message
    /// is returned.
    /// </summary>
    function SendVenue(ASendVenueArgument: TtgSendVenueArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send phone contacts. On success, the sent Message is
    /// returned.
    /// </summary>
    function SendContact(ASendContactArgument: TtgSendContactArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send a native poll. On success, the sent Message is returned.
    /// </summary>
    function SendPool(ASendPollArgument: TtgSendPollArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send an animated emoji that will display a random value. On
    /// success, the sent Message is returned.
    /// </summary>
    function SendDice(ASendDice: TtgSendDiceArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method when you need to tell the user that something is happening on
    /// the bot's side. The status is set for 5 seconds or less (when a message arrives
    /// from your bot, Telegram clients clear its typing status). Returns True on
    /// success.
    /// </summary>
    /// <remarks>
    /// We only recommend using this method when a response from the bot will take a
    /// noticeable amount of time to arrive.
    /// </remarks>
    function SendChatAction(AChatAction: TtgSendChatActionArgument): ItgResponse<Boolean>;
{$ENDREGION}
    /// <summary> Use this method to generate a new invite link for a chat; any
    /// previously generated link is revoked. The bot must be an administrator in the
    /// chat for this to work and must have the appropriate admin rights.
    /// </summary>
    /// <returns>  Returns the new invite link as String on success.
    /// </returns>
    function ExportChatInviteLink(AChatID: TtgExportChatInviteLinkArgument): ItgResponse<string>;
    function getChat(AGetChatArgument: TtgGetChatArgument): ItgResponse<TtgChat>;
    constructor Create; overload;
    constructor Create(const AToken: string); overload;

    destructor Destroy; override;
    property BotToken: string read GetBotToken write SetBotToken;
    property CloudApi: TCloudApiClient read FCloudApi write FCloudApi;
    property AutoFreeRequestArgument: Boolean read FAutoFreeRequestArgument write FAutoFreeRequestArgument;
  end;

implementation

uses
  CloudApi.Response,
  CloudApi.RequestArgument,
  CloudApi.Types,
  System.Net.HttpClient,
  TelegramBotApi.CloudApi.Authenticator,
  TelegramBotApi.CloudApi.Converter;

constructor TTelegramBotApi.Create;
begin
  inherited Create;
  FCloudApi := TCloudApiClient.Create;
  FCloudApi.Authenticator := TTelegramAuthenticator.Create(BotToken);
  FCloudApi.HttpClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
  TtgConverters.TelegramConverter;
  FCloudApi.BaseUrl := 'https://api.telegram.org/bot{token}';
  FAutoFreeRequestArgument := False;
end;

constructor TTelegramBotApi.Create(const AToken: string);
begin
  Self.Create;
  BotToken := AToken;
end;

function TTelegramBotApi.DeleteWebhook: Boolean;
begin
  Result := InternalExecuteCustom<TtgDeleteWebhookArgument, Boolean>(TtgDeleteWebhookArgument.Default);
end;

destructor TTelegramBotApi.Destroy;
begin
  FCloudApi.Free;
  inherited Destroy;
end;

function TTelegramBotApi.Close: ItgResponse<Boolean>;
var
  lClose: TtgCloseArgunent;
begin
  lClose := TtgCloseArgunent.Create;
  try
    Result := InternalExecute<TtgCloseArgunent, Boolean>(lClose);
  finally
    lClose.Free;
  end;
end;

function TTelegramBotApi.CopyMessage(ACopyMessageArgument: TtgCopyMessageArgument): ItgResponse<Int64>;
begin
  Result := InternalExecute<TtgCopyMessageArgument, Int64>(ACopyMessageArgument);
end;

function TTelegramBotApi.EditMessageLiveLocation(AEditMessageLiveLocationArgument: TtgEditMessageLiveLocationArgument)
  : ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgEditMessageLiveLocationArgument, TtgMessage>(AEditMessageLiveLocationArgument);
end;

function TTelegramBotApi.EditMessageLiveLocation(AEditMessageLiveLocationArgument
  : TtgEditMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgEditMessageLiveLocationHaveInlineMessageIDArgument, TtgMessage>
    (AEditMessageLiveLocationArgument);
end;

function TTelegramBotApi.ExportChatInviteLink(AChatID: TtgExportChatInviteLinkArgument): ItgResponse<string>;
begin
  Result := InternalExecute<TtgExportChatInviteLinkArgument, string>(AChatID);
end;

function TTelegramBotApi.ForwardMessage(AForwardMessageArgument: TtgForwardMessageArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgForwardMessageArgument, TtgMessage>(AForwardMessageArgument);
end;

function TTelegramBotApi.GetBotToken: string;
begin
  Result := FBotToken;
end;

function TTelegramBotApi.getChat(AGetChatArgument: TtgGetChatArgument): ItgResponse<TtgChat>;
begin
  Result := InternalExecute<TtgGetChatArgument, TtgChat>(AGetChatArgument);
end;

function TTelegramBotApi.GetMe: ItgResponse<TtgUser>;
var
  lGetMe: TtgGetMeArgunent;
begin
  lGetMe := TtgGetMeArgunent.Create;
  try
    Result := InternalExecute<TtgGetMeArgunent, TtgUser>(lGetMe);
  finally
    lGetMe.Free;
  end;
end;

function TTelegramBotApi.GetUpdates(AGetUpdatesArgument: TtgGetUpdatesArgument): ItgResponse<TArray<TtgUpdate>>;
begin
  Result := InternalExecute < TtgGetUpdatesArgument, TArray < TtgUpdate >> (AGetUpdatesArgument);
end;

class function TTelegramBotApi.GetUpdates(const AJson: string): ItgResponse<TArray<TtgUpdate>>;
var
  lCA: TCloudApiClient;
begin
  lCA := TCloudApiClient.Create;
  try
    Result := lCA.Serializer.Deserialize < TtgResponse < TArray<TtgUpdate> >> (AJson);
  finally
    lCA.Free;
  end;
end;

function TTelegramBotApi.GetWebhookInfo: ItgResponse<TtgWebhookInfo>;
begin
  Result := InternalExecute<TtgGetWebhookInfoArgument, TtgWebhookInfo>(TtgGetWebhookInfoArgument.Default);
end;

function TTelegramBotApi.InternalExecute<TArgument, TResult>(AArgument: TArgument): ItgResponse<TResult>;
var
  LReq: IcaRequest;
begin
  LReq := TcaRequestArgument.Current.ObjToRequest<TArgument>(AArgument);
  Result := InternalExecute<TResult>(LReq);
end;

function TTelegramBotApi.InternalExecute<TResult>(ARequest: IcaRequest): ItgResponse<TResult>;
var
  LCloudResponse: IcaResponse<TtgResponse<TResult>>;
begin
  LCloudResponse := FCloudApi.Execute < TtgResponse < TResult >> (ARequest);
  Result := LCloudResponse.Data;
  Result.CloudResponse := LCloudResponse;
end;

function TTelegramBotApi.InternalExecuteCustom<TArgument, TResult>(AArgument: TArgument): TResult;
var
  LReq: IcaRequest;
begin
  LReq := TcaRequestArgument.Current.ObjToRequest<TArgument>(AArgument);
  Result := InternalExecuteCustom<TResult>(LReq);
end;

function TTelegramBotApi.InternalExecuteCustom<TResult>(ARequest: IcaRequest): TResult;
var
  LCloudResponse: IcaResponse<TResult>;
begin
  LCloudResponse := FCloudApi.Execute<TResult>(ARequest);
  Result := LCloudResponse.Data;
end;

function TTelegramBotApi.LogOut: ItgResponse<Boolean>;
var
  lLogOut: TtgLogOutArgunent;
begin
  lLogOut := TtgLogOutArgunent.Create;
  try
    Result := InternalExecute<TtgLogOutArgunent, Boolean>(lLogOut);
  finally
    lLogOut.Free;
  end;
end;

function TTelegramBotApi.SendAnimation(ASendAnimationArgument: TtgSendAnimationArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendAnimationArgument, TtgMessage>(ASendAnimationArgument);
end;

function TTelegramBotApi.SendAudio(ASendAudioArgument: TtgSendAudioArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendAudioArgument, TtgMessage>(ASendAudioArgument);
end;

function TTelegramBotApi.SendChatAction(AChatAction: TtgSendChatActionArgument): ItgResponse<Boolean>;
begin
  Result := InternalExecute<TtgSendChatActionArgument, Boolean>(AChatAction);
end;

function TTelegramBotApi.SendContact(ASendContactArgument: TtgSendContactArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendContactArgument, TtgMessage>(ASendContactArgument);
end;

function TTelegramBotApi.SendDice(ASendDice: TtgSendDiceArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendDiceArgument, TtgMessage>(ASendDice);
end;

function TTelegramBotApi.SendDocument(ASendDocumentArgument: TtgSendDocumentArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendDocumentArgument, TtgMessage>(ASendDocumentArgument);
end;

function TTelegramBotApi.SendLocation(ASendLocationArgument: TtgSendLocationArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendLocationArgument, TtgMessage>(ASendLocationArgument);
end;

function TTelegramBotApi.SendMediaGroup(ASendMediaGroupArgument: TtgSendMediaGroupArgument)
  : ItgResponse<TArray<TtgMessage>>;
var
  LRequest: IcaRequest;
  LMedia: TtgInputMedia;
begin
  LRequest := TcaRequestArgument.Current.ObjToRequest<TtgSendMediaGroupArgument>(ASendMediaGroupArgument);
  for LMedia in ASendMediaGroupArgument.Media do
  begin
    case LMedia.GetFileToSend.&Type of
      TcaFileToSendType.File, TcaFileToSendType.Stream:
        LRequest.AddFile(LMedia.GetFileToSend);
    end;
  end;
  Result := InternalExecute < TArray < TtgMessage >> (LRequest);
end;

function TTelegramBotApi.SendMessage(ASendMessageArgument: TtgMessageArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgMessageArgument, TtgMessage>(ASendMessageArgument);
end;

function TTelegramBotApi.SendPhoto(ASendPhotoArgument: TtgSendPhotoArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendPhotoArgument, TtgMessage>(ASendPhotoArgument);
end;

function TTelegramBotApi.SendPool(ASendPollArgument: TtgSendPollArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendPollArgument, TtgMessage>(ASendPollArgument);
end;

function TTelegramBotApi.SendVenue(ASendVenueArgument: TtgSendVenueArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVenueArgument, TtgMessage>(ASendVenueArgument);
end;

function TTelegramBotApi.SendVideo(ASendVideoArgument: TtgSendVideoArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVideoArgument, TtgMessage>(ASendVideoArgument);
end;

function TTelegramBotApi.SendVideoNote(ASendVideoNoteArgument: TtgSendVideoNoteArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVideoNoteArgument, TtgMessage>(ASendVideoNoteArgument);
end;

function TTelegramBotApi.SendVoice(ASendVoiceArgument: TtgSendVoiceArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVoiceArgument, TtgMessage>(ASendVoiceArgument);
end;

procedure TTelegramBotApi.SetBotToken(const Value: string);
begin
  if FBotToken <> Value then
  begin
    FBotToken := Value;
    TTelegramAuthenticator(FCloudApi.Authenticator).BotToken := Value;
  end;
end;

function TTelegramBotApi.SetWebhook(SetWebhookArgument: TtgSetWebhookArgument): Boolean;
begin
  Result := InternalExecuteCustom<TtgSetWebhookArgument, Boolean>(SetWebhookArgument);
end;

function TTelegramBotApi.StopMessageLiveLocation(AEditMessageLiveLocationArgument
  : TtgStopMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgStopMessageLiveLocationHaveInlineMessageIDArgument, TtgMessage>
    (AEditMessageLiveLocationArgument);
end;

function TTelegramBotApi.StopMessageLiveLocation(AEditMessageLiveLocationArgument: TtgStopMessageLiveLocationArgument)
  : ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgStopMessageLiveLocationArgument, TtgMessage>(AEditMessageLiveLocationArgument);
end;

end.
