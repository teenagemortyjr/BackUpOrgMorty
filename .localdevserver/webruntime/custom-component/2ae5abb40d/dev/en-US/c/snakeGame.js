Webruntime.define('lwc/snakeGame', ['lwc'], function (lwc) { 'use strict';

    function stylesheet(hostSelector, shadowSelector, nativeShadow) {
      return ".header" + shadowSelector + " {background: rgb(170, 0, 255);color: white;font-size: 1rem;}\n.game-container" + shadowSelector + " {width: 100%;height: 60vh;background: rgb(193, 255, 70);text-align: center;}\n.game-play" + shadowSelector + " div" + shadowSelector + " {width: 20px;height: 20px;background: rgb(230, 250, 190);display: inline-block;}\n.snake" + shadowSelector + " {background: green !important;}\n.food" + shadowSelector + " {background: red !important;border-radius: 50%;}\n.overlay" + shadowSelector + " {position: relative;width: 100%;margin-top: -30vh;left: 0;bottom: 0;z-index: 9;}\n.overlay-content" + shadowSelector + " {position: relative;top: 50%;text-align: center;}\n";
    }
    var _implicitStylesheets = [stylesheet];

    function tmpl($api, $cmp, $slotset, $ctx) {
      const {
        t: api_text,
        d: api_dynamic,
        h: api_element,
        k: api_key,
        i: api_iterator,
        b: api_bind
      } = $api;
      const {
        _m0,
        _m1
      } = $ctx;
      return [api_element("div", {
        classMap: {
          "header": true,
          "slds-var-p-around_medium": true
        },
        key: 4
      }, [api_element("div", {
        classMap: {
          "slds-grid": true
        },
        key: 3
      }, [api_element("div", {
        classMap: {
          "slds-col": true,
          "slds-size_1-of-3": true
        },
        key: 0
      }, [api_text("Score: "), api_dynamic($cmp.score)]), api_element("div", {
        classMap: {
          "slds-col": true,
          "slds-size_1-of-3": true,
          "slds-text-align_center": true
        },
        key: 1
      }, [api_text("Speed: "), api_dynamic($cmp.displaySpeed), api_text("x")]), api_element("div", {
        classMap: {
          "slds-col": true,
          "slds-size_1-of-3": true,
          "slds-text-align_right": true
        },
        key: 2
      }, [api_text("High Score: "), api_dynamic($cmp.highScore)])])]), api_element("div", {
        classMap: {
          "game-container": true
        },
        key: 15
      }, [api_element("div", {
        classMap: {
          "game-play": true
        },
        key: 6
      }, api_iterator($cmp.gameBlocks, function (block) {
        return api_element("div", {
          className: block.class,
          attrs: {
            "data-reference": block.id
          },
          key: api_key(5, block.id)
        }, [api_text("\xA0")]);
      })), $cmp.showOverlay ? api_element("div", {
        classMap: {
          "overlay": true
        },
        key: 14
      }, [api_element("div", {
        classMap: {
          "overlay-content": true
        },
        key: 13
      }, [$cmp.gameOver ? api_element("div", {
        classMap: {
          "slds-text-heading_large": true
        },
        key: 7
      }, [api_text("Game Over!")]) : null, $cmp.gameOver ? api_element("br", {
        key: 8
      }, []) : null, $cmp.gameOver ? api_element("button", {
        classMap: {
          "slds-button": true,
          "slds-button_brand": true
        },
        key: 9,
        on: {
          "click": _m0 || ($ctx._m0 = api_bind($cmp.resetGame))
        }
      }, [api_text("Play Again")]) : null, !$cmp.gameOver ? api_element("div", {
        classMap: {
          "slds-text-heading_medium": true
        },
        key: 10
      }, [api_text("Use Arrow Keys to move the snake")]) : null, !$cmp.gameOver ? api_element("br", {
        key: 11
      }, []) : null, !$cmp.gameOver ? api_element("button", {
        classMap: {
          "slds-button": true,
          "slds-button_brand": true
        },
        key: 12,
        on: {
          "click": _m1 || ($ctx._m1 = api_bind($cmp.startGame))
        }
      }, [api_text("Start Game")]) : null])]) : null])];
    }

    var _tmpl = lwc.registerTemplate(tmpl);
    tmpl.stylesheets = [];

    if (_implicitStylesheets) {
      tmpl.stylesheets.push.apply(tmpl.stylesheets, _implicitStylesheets);
    }
    tmpl.stylesheetTokens = {
      hostAttribute: "lwc-snakeGame_snakeGame-host",
      shadowAttribute: "lwc-snakeGame_snakeGame"
    };

    class snakeGame extends lwc.LightningElement {
      constructor(...args) {
        super(...args);
        this.score = 0;
        this.highScore = 0;
        this.blockSize = 20;
        this.gameBlocks = [];
        this.renderComplete = false;
        this.xSpeed = 1;
        this.ySpeed = 0;
        this.xHead = 0;
        this.yHead = 0;
        this.xMax = void 0;
        this.yMax = void 0;
        this.tail = [];
        this.showOverlay = true;
        this.gameOver = false;
        this.speed = 1;
        this.intervalObj = void 0;
      }
      connectedCallback() {
        this.highScore = localStorage.getItem('lwc_snake_high') ? localStorage.getItem('lwc_snake_high') : 0;
      }
      get displaySpeed() {
        return this.speed.toFixed(1);
      }
      startGame() {
        this.showOverlay = false;
        this.intervalObj = setInterval(() => {
          this.move();
        }, 300 / this.speed);
      }
      addSpeed() {
        this.speed = this.speed + 0.1;
        clearInterval(this.intervalObj);
        this.startGame();
      }
      move() {
        const lastElement = this.tail[this.tail.length - 1];
        if (lastElement !== `${this.xHead}:${this.yHead}`) {
          this.tail.push(`${this.xHead}:${this.yHead}`);
          const removedElement = this.tail.shift();
          const curPosIndex = this.gameBlocks.findIndex(x => x.id === removedElement);
          this.gameBlocks[curPosIndex].snake = false;
          this.gameBlocks[curPosIndex].class = '';
        }
        this.xHead += this.xSpeed;
        this.yHead += this.ySpeed;
        if (this.xHead >= this.xMax) {
          this.xHead = 0;
        }
        if (this.xHead < 0) {
          this.xHead = this.xMax - 1;
        }
        if (this.yHead >= this.yMax) {
          this.yHead = 0;
        }
        if (this.yHead < 0) {
          this.yHead = this.yMax - 1;
        }
        if (this.tail.includes(`${this.xHead}:${this.yHead}`)) {
          this.exitGame();
        } else {
          const newPosIndex = this.gameBlocks.findIndex(x => x.id === `${this.xHead}:${this.yHead}`);
          this.gameBlocks[newPosIndex].snake = true;
          this.gameBlocks[newPosIndex].class = 'snake';
          if (this.gameBlocks[newPosIndex].food) {
            this.score++;
            if (this.score > this.highScore) {
              this.highScore = this.score;
              localStorage.setItem('lwc_snake_high', this.highScore);
            }
            this.addSpeed();
            this.tail.push(`${this.xHead}:${this.yHead}`);
            this.gameBlocks[newPosIndex].food = false;
            this.generateFood();
          }
        }
      }
      addKeyboardControls() {
        window.addEventListener('keydown', e => {
          e.preventDefault();
          switch (e.key) {
            case 'ArrowUp':
              this.xSpeed = 0;
              this.ySpeed = -1;
              break;
            case 'ArrowDown':
              this.xSpeed = 0;
              this.ySpeed = 1;
              break;
            case 'ArrowLeft':
              this.xSpeed = -1;
              this.ySpeed = 0;
              break;
            case 'ArrowRight':
              this.xSpeed = 1;
              this.ySpeed = 0;
              break;
          }
        });
      }
      generateFood() {
        const xFood = Math.floor(Math.random() * (this.xMax - 1));
        const yFood = Math.floor(Math.random() * (this.yMax - 1));
        if (!this.tail.includes(`${xFood}:${yFood}`)) {
          const foodPosIndex = this.gameBlocks.findIndex(x => x.id === `${xFood}:${yFood}`);
          this.gameBlocks[foodPosIndex].food = true;
          this.gameBlocks[foodPosIndex].class = 'food';
        } else {
          this.generateFood();
        }
      }
      renderGameBlocks() {
        const gameContainerEl = this.template.querySelector('.game-container');
        const eWidth = gameContainerEl.clientWidth;
        const eHeight = gameContainerEl.clientHeight;
        this.xMax = Math.floor(eWidth / this.blockSize);
        this.yMax = Math.floor(eHeight / this.blockSize);
        const tmpBlocks = [];
        for (let y = 0; y < this.yMax; y++) {
          for (let x = 0; x < this.xMax; x++) {
            let obj;
            if (x === 0 && y === 0) {
              obj = {
                id: `${x}:${y}`,
                snake: true,
                food: false,
                class: 'snake'
              };
            } else {
              obj = {
                id: `${x}:${y}`,
                snake: false,
                food: false,
                class: ''
              };
            }
            tmpBlocks.push(obj);
          }
        }
        this.gameBlocks = tmpBlocks;
      }
      renderedCallback() {
        if (!this.renderComplete) {
          this.renderComplete = true;
          this.renderGameBlocks();
          this.addKeyboardControls();
          this.generateFood();
          window.addEventListener('resize', () => {
            this.resetGameMetrics();
            this.showOverlay = true;
            this.gameOver = false;
          });
        }
      }
      resetGameMetrics() {
        this.xSpeed = 1;
        this.ySpeed = 0;
        this.xHead = 0;
        this.yHead = 0;
        this.tail = [];
        this.score = 0;
        this.speed = 1;
        this.renderGameBlocks();
        this.generateFood();
        clearInterval(this.intervalObj);
      }
      resetGame() {
        this.resetGameMetrics();
        this.startGame();
      }
      exitGame() {
        this.showOverlay = true;
        this.gameOver = true;
        clearInterval(this.intervalObj);
      }
    }
    lwc.registerDecorators(snakeGame, {
      track: {
        gameBlocks: 1
      },
      fields: ["score", "highScore", "blockSize", "renderComplete", "xSpeed", "ySpeed", "xHead", "yHead", "xMax", "yMax", "tail", "showOverlay", "gameOver", "speed", "intervalObj"]
    });
    var snakeGame$1 = lwc.registerComponent(snakeGame, {
      tmpl: _tmpl
    });

    return snakeGame$1;

});
