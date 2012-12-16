module.exports = function (grunt) {

    grunt.initConfig({

        lint: {
            all: ['grunt.js', 'web-app/js/*.js']
        },

        jshint: {
            options: {
                browser: true
            },
            all: ['grunt.js', 'web-app/js/*.js']
        },

        less: {
            compile: {
                options: {
                    compress: true
                },
                files: {
                    'web-app/css/app.css': 'web-app/css/app.less'
                }
            }
        },

        handlebars: {
            "web-app/js/jst.js": [
                "web-app/templates/**/*.handlebars"
            ]
        },

        jasmine: {
            all: ['web-app/js/spec/**/*.html']
        },

        watch: {
            files: ['web-app/css/app.less', 'web-app/templates/**/*.handlebars'],
            tasks: 'less handlebars'
        }
    });


    grunt.loadNpmTasks('grunt-contrib');
    grunt.loadNpmTasks('grunt-jasmine-task');

    grunt.registerMultiTask("handlebars", "Compile handlebars templates to JST file", function () {

        var options = grunt.helper("options", this),
//            namespace = options.namespace || "JST",
            files = grunt.file.expand(this.data);

        var output = '(function() {\n  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};\n';
        output += grunt.helper("handlebars", files);
        output += '\n})();';
        grunt.file.write(this.target, output);

        // Fail task if errors were logged.
        if (grunt.errors) { return false; }

        // Otherwise, print a success message.
        grunt.log.writeln("File \"" + this.target + "\" created.");
    });

    grunt.registerHelper("handlebars", function (files) {
        return files ? files.map(function (filepath) {
            var templateFunction = require("handlebars").precompile(grunt.file.read(filepath));
            var templateName = filepath;
            templateName = templateName.replace(/^web-app\/templates\//, '').replace(/.handlebars$/, '');

            return "templates['" + templateName + "'] = template(" + templateFunction + ");";
        }).join("\n\n") : "";
    });

    grunt.registerTask('default', 'less handlebars');
};