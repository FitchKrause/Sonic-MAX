    if(instance_exists(objParentEnemy) == false)
        exit;

    Off = 15+(10*(Shield == consShieldInstashield))    

    _ObjectHandle = collision_rectangle(x-Off, y-Off, x+Off, y+Off, objParentEnemy, false, true)
    if(_ObjectHandle != noone){
        if(Action == consActionRolling || Action == consActionJumping || Action == consActionSpindash || Action == consActionGlide
        || ShieldAction == true || Invincibility == 2 || SuperForm || Homing){
            if(Gravity < 0 || y > _ObjectHandle.y){
                Gravity -= sign(Gravity);
            }else if(Gravity > 0 && y < _ObjectHandle.y){
                if(KeyA || JumpVariable == false){
                    Gravity *= -1;
                }else{
                    Gravity = max(-4, Gravity*-1);
                }
            }
            EnemyChain += 1;
            if(EnemyChain == 1){
                ScoreAdd = instance_create(_ObjectHandle.x, y, objScoreAdd)
                ScoreAdd.Score = 100;
            }else if(EnemyChain == 2){
                ScoreAdd = instance_create(_ObjectHandle.x, y, objScoreAdd)
                ScoreAdd.Score = 200;
            }else if(EnemyChain == 3){
                ScoreAdd = instance_create(_ObjectHandle.x, y, objScoreAdd)
                ScoreAdd.Score = 500;
            }else if(EnemyChain >= 4 && EnemyChain < 16){
                ScoreAdd = instance_create(_ObjectHandle.x, y, objScoreAdd)
                ScoreAdd.Score = 1000;
            }else if(EnemyChain >= 16){
                ScoreAdd = instance_create(_ObjectHandle.x, y, objScoreAdd)
                ScoreAdd.Score = 10000;
            }
            if(Homing){
                Speed           = 0;
                Gravity         = -3;
                ShieldUsable    = true;
            }
            with(_ObjectHandle)
                instance_destroy();

        }else
            scrPlayerHurt(_ObjectHandle, sndPlayerDead);
    }