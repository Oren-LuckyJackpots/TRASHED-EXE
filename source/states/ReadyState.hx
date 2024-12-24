package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
import backend.StageData;

class ReadyState extends MusicBeatState
{
    private var startTxt:Alphabet;

    private var selectedSomethin:Bool = false;

    override function create()
    {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Ready...?", null);
		#end

		persistentUpdate = persistentDraw = true;
		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);

        startTxt = new Alphabet(.0, .0, 'PLAY?');
		startTxt.screenCenter();
        add(startTxt);

        super.create();
    }

    override function update(elapsed:Float)
    {
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume = Math.min(FlxG.sound.music.volume + 0.5 * elapsed, 0.8);

		FlxG.camera.shake(0.05, 0.01);

        if (!selectedSomethin && controls.ACCEPT)
        {
            FlxG.sound.play(Paths.sound('confirmMenu'));

			// Nevermind that's stupid lmao
			try
			{
				PlayState.storyPlaylist = ['too-slow-rerun-juiced'];
				PlayState.isStoryMode = true;
	
				var diffic = /*Difficulty.getFilePath(2);
				if(diffic == null) diffic = */'-hard';
	
				PlayState.storyDifficulty = 2;
	
				Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;

                var directory = StageData.forceNextDirectory;
                LoadingState.loadNextDirectory();
                StageData.forceNextDirectory = directory;
    
                LoadingState.prepareToSong();
				FlxG.camera.flash(FlxColor.RED);
				FlxTween.tween(FlxG.camera, { zoom: 2.0 }, 1.5, { ease: FlxEase.expoIn, onComplete: _ -> {
					FlxG.camera.fade(FlxColor.BLACK, 0.0001);
				}});
                new FlxTimer().start(2, function(tmr:FlxTimer)
                {
                    #if !SHOW_LOADING_SCREEN FlxG.sound.music.stop(); #end
                    LoadingState.loadAndSwitchState(new PlayState(), true);
                    FreeplayState.destroyFreeplayVocals();
                });
                
                #if (MODS_ALLOWED && DISCORD_ALLOWED)
                DiscordClient.loadModRPC();
                #end

                selectedSomethin = true;
			}
			catch(e:Dynamic)
			{
				trace('ERROR! $e');
				return;
			}
        }

		super.update(elapsed);
    }
}