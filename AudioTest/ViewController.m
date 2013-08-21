//
//  ViewController.m
//  AudioTest
//
//  Created by John Stewart on 8/21/13.
//  Copyright (c) 2013 John Stewart. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#define MINVALUE 1000
#define MAXVALUE 1351

@interface ViewController ()

@end

int currentNumber;
NSDictionary *soundNames;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set up slider
    [self.numberSlider addTarget:self action:@selector(sliderTouched) forControlEvents:UIControlEventAllTouchEvents];

    // Set defaults on label
    currentNumber = 1000;
    self.numberLabel.text = @"1000";
    
    // Initialize dictionary, from http://iphonedevwiki.net/index.php/AudioServices
    {
    soundNames = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"new-mail.caf MailReceived", @"1000",
                  @"mail-sent.caf MailSent", @"1001",
                  @"Voicemail.caf VoicemailReceived", @"1002",
                  @"ReceivedMessage.caf SMSReceived", @"1003",
                  @"SentMessage.caf SMSSent", @"1004",
                  @"alarm.caf CalendarAlert", @"1005",
                  @"low_power.caf LowPower", @"1006",
                  @"sms-received1.caf SMSReceived_Alert", @"1007",
                  @"sms-received2.caf SMSReceived_Alert", @"1008",
                  @"sms-received3.caf SMSReceived_Alert", @"1009",
                  @"sms-received4.caf SMSReceived_Alert", @"1010",
                  @"- SMSReceived_Vibrate", @"1011",
                  @"sms-received1.caf SMSReceived_Alert", @"1012",
                  @"sms-received5.caf SMSReceived_Alert", @"1013",
                  @"sms-received6.caf SMSReceived_Alert", @"1014",
                  @"Voicemail.caf -", @"1015",
                  @"tweet_sent.caf SMSSent", @"1016",
                  @"Anticipate.caf SMSReceived_Alert", @"1020",
                  @"Bloom.caf SMSReceived_Alert", @"1021",
                  @"Calypso.caf SMSReceived_Alert", @"1022",
                  @"Choo_Choo.caf SMSReceived_Alert", @"1023",
                  @"Descent.caf SMSReceived_Alert", @"1024",
                  @"Fanfare.caf SMSReceived_Alert", @"1025",
                  @"Ladder.caf SMSReceived_Alert", @"1026",
                  @"Minuet.caf SMSReceived_Alert", @"1027",
                  @"News_Flash.caf SMSReceived_Alert", @"1028",
                  @"Noir.caf SMSReceived_Alert", @"1029",
                  @"Sherwood_Forest.caf SMSReceived_Alert", @"1030",
                  @"Spell.caf SMSReceived_Alert", @"1031",
                  @"Suspense.caf SMSReceived_Alert", @"1032",
                  @"Telegraph.caf SMSReceived_Alert", @"1033",
                  @"Tiptoes.caf SMSReceived_Alert", @"1034",
                  @"Typewriters.caf SMSReceived_Alert", @"1035",
                  @"Update.caf SMSReceived_Alert", @"1036",
                  @"ussd.caf USSDAlert", @"1050",
                  @"SIMToolkitCallDropped.caf SIMToolkitTone", @"1051",
                  @"SIMToolkitGeneralBeep.caf SIMToolkitTone", @"1052",
                  @"SIMToolkitNegativeACK.caf SIMToolkitTone", @"1053",
                  @"SIMToolkitPositiveACK.caf SIMToolkitTone", @"1054",
                  @"SIMToolkitSMS.caf SIMToolkitTone", @"1055",
                  @"Tink.caf PINKeyPressed", @"1057",
                  @"ct-busy.caf AudioToneBusy", @"1070",
                  @"ct-congestion.caf AudioToneCongestion", @"1071",
                  @"ct-path-ack.caf AudioTonePathAcknowledge", @"1072",
                  @"ct-error.caf AudioToneError", @"1073",
                  @"ct-call-waiting.caf AudioToneCallWaiting", @"1074",
                  @"ct-keytone2.caf AudioToneKey2", @"1075",
                  @"lock.caf ScreenLocked", @"1100",
                  @"unlock.caf ScreenUnlocked", @"1101",
                  @"- FailedUnlock", @"1102",
                  @"Tink.caf KeyPressed", @"1103",
                  @"Tock.caf KeyPressed", @"1104",
                  @"Tock.caf KeyPressed", @"1105",
                  @"beep-beep.caf ConnectedToPower", @"1106",
                  @"RingerChanged.caf RingerSwitchIndication", @"1107",
                  @"photoShutter.caf CameraShutter", @"1108",
                  @"shake.caf ShakeToShuffle", @"1109",
                  @"jbl_begin.caf JBL_Begin", @"1110",
                  @"jbl_confirm.caf JBL_Confirm", @"1111",
                  @"jbl_cancel.caf JBL_Cancel", @"1112",
                  @"begin_record.caf BeginRecording", @"1113",
                  @"end_record.caf EndRecording", @"1114",
                  @"jbl_ambiguous.caf JBL_Ambiguous", @"1115",
                  @"jbl_no_match.caf JBL_NoMatch", @"1116",
                  @"begin_video_record.caf BeginVideoRecording", @"1117",
                  @"end_video_record.caf EndVideoRecording", @"1118",
                  @"vc~invitation-accepted.caf VCInvitationAccepted", @"1150",
                  @"vc~ringing.caf VCRinging", @"1151",
                  @"vc~ended.caf VCEnded", @"1152",
                  @"ct-call-waiting.caf VCCallWaiting", @"1153",
                  @"vc~ringing.caf VCCallUpgrade", @"1154",
                  @"dtmf-0.caf TouchTone", @"1200",
                  @"dtmf-1.caf TouchTone", @"1201",
                  @"dtmf-2.caf TouchTone", @"1202",
                  @"dtmf-3.caf TouchTone", @"1203",
                  @"dtmf-4.caf TouchTone", @"1204",
                  @"dtmf-5.caf TouchTone", @"1205",
                  @"dtmf-6.caf TouchTone", @"1206",
                  @"dtmf-7.caf TouchTone", @"1207",
                  @"dtmf-8.caf TouchTone", @"1208",
                  @"dtmf-9.caf TouchTone", @"1209",
                  @"dtmf-star.caf TouchTone", @"1210",
                  @"dtmf-pound.caf TouchTone", @"1211",
                  @"long_low_short_high.caf Headset_StartCall", @"1254",
                  @"short_double_high.caf Headset_Redial", @"1255",
                  @"short_low_high.caf Headset_AnswerCall", @"1256",
                  @"short_double_low.caf Headset_EndCall", @"1257",
                  @"short_double_low.caf Headset_CallWaitingActions", @"1258",
                  @"middle_9_short_double_low.caf Headset_TransitionEnd", @"1259",
                  @"Voicemail.caf SystemSoundPreview", @"1300",
                  @"ReceivedMessage.caf SystemSoundPreview", @"1301",
                  @"new-mail.caf SystemSoundPreview", @"1302",
                  @"mail-sent.caf SystemSoundPreview", @"1303",
                  @"alarm.caf SystemSoundPreview", @"1304",
                  @"lock.caf SystemSoundPreview", @"1305",
                  @"Tock.caf KeyPressClickPreview", @"1306",
                  @"sms-received1.caf SMSReceived_Selection", @"1307",
                  @"sms-received2.caf SMSReceived_Selection", @"1308",
                  @"sms-received3.caf SMSReceived_Selection", @"1309",
                  @"sms-received4.caf SMSReceived_Selection", @"1310",
                  @"- SMSReceived_Vibrate", @"1311",
                  @"sms-received1.caf SMSReceived_Selection", @"1312",
                  @"sms-received5.caf SMSReceived_Selection", @"1313",
                  @"sms-received6.caf SMSReceived_Selection", @"1314",
                  @"Voicemail.caf SystemSoundPreview", @"1315",
                  @"Anticipate.caf SMSReceived_Selection", @"1320",
                  @"Bloom.caf SMSReceived_Selection", @"1321",
                  @"Calypso.caf SMSReceived_Selection", @"1322",
                  @"Choo_Choo.caf SMSReceived_Selection", @"1323",
                  @"Descent.caf SMSReceived_Selection", @"1324",
                  @"Fanfare.caf SMSReceived_Selection", @"1325",
                  @"Ladder.caf SMSReceived_Selection", @"1326",
                  @"Minuet.caf SMSReceived_Selection", @"1327",
                  @"News_Flash.caf SMSReceived_Selection", @"1328",
                  @"Noir.caf SMSReceived_Selection", @"1329",
                  @"Sherwood_Forest.caf SMSReceived_Selection", @"1330",
                  @"Spell.caf SMSReceived_Selection", @"1331",
                  @"Suspense.caf SMSReceived_Selection", @"1332",
                  @"Telegraph.caf SMSReceived_Selection", @"1333",
                  @"Tiptoes.caf SMSReceived_Selection", @"1334",
                  @"Typewriters.caf SMSReceived_Selection", @"1335",
                  @"Update.caf SMSReceived_Selection", @"1336",
                  @"- RingerVibeChanged", @"1350",
                  @"- SilentVibeChanged", @"1351",
                  nil];
    }
}

- (void) updateLabels {
    self.numberLabel.text = [NSString stringWithFormat:@"%d", currentNumber];
    self.descriptionLabel.text = [soundNames valueForKey:self.numberLabel.text];
}
- (void) sliderTouched {
    currentNumber = self.numberSlider.value;
    [self updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playPressed:(id)sender {
    AudioServicesPlaySystemSound(currentNumber);

}

- (IBAction)minusPressed:(id)sender {
    if (currentNumber > MINVALUE) currentNumber--;
    self.numberSlider.value = currentNumber;
    [self updateLabels];
}

- (IBAction)plusPressed:(id)sender {
    if (currentNumber < MAXVALUE) currentNumber++;
    self.numberSlider.value = currentNumber;
    [self updateLabels];
}
@end
