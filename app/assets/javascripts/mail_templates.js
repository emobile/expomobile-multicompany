$(function() {
    $("#mail_template_content").htmlarea({
        toolbar: [
            "html",
            "|",
            "bold", "italic", "underline", "strikethrough",
            "|",
            "subscript", "superscript",
            "|",
            "increasefontsize", "decreasefontsize", "forecolor",
            "|",
            "unorderedlist", "orderedlist",
            "|",
            "indent", "outdent",
            "|",
            "justifyleft", "justifycenter", "justifyright",
            "|",
            "link", "unlink", "image", "horizontalrule",
            "|",
            "p", "h1", "h2", "h3", "h4", "h5", "h6",
            "|",
            "cut", "copy", "paste"
        ]
    });
});