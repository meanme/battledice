path = require 'path'
rootPath = path.normalize "#{__dirname}/.."

templatePath = path.normalize "#{__dirname}/../views"

module.exports =
    db: 'mongodb://localhost/battledice'
    root: rootPath
    app: { name: 'BattleDice'}

    facebook:
        clientID: '438134219641787'
        clientSecret: '1b0b390f46a764ad84bccd1e4619d656'
        callbackURL: 'http://localhost:3000/auth/facebook/callback'


    heroes: [
        {
            types: []
            name: 'Hero 00'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['r', 'b']
                    effect: 'atk:200'
                },
                {
                    cost: ['r', 'r']
                    effect: 'atk:150'
                }
            ]

        },
        {
            types: []
            name: 'Hero 01'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 02'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 03'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 04'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 05'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 06'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 07'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 09'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 10'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 11'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        },

        {
            types: []
            name: 'Hero 12'
            picture: 'http://placehold.it/175x200'
        #preview: 'http://placehold.it/75x75'
            preview: 'http://localhost:3000/img/preview_75x75.png'
            atk: 90
            evo: 3
            skills: [
                {
                    cost: ['y', 'y']
                    effect: 'atk:250'
                }
            ]
        }
    ]