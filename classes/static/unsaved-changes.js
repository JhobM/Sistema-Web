(function () {
    var form = document.querySelector('form[data-confirm-unsaved]');

    if (form === null) {
        return;
    }

    var fields = form.querySelectorAll(
        'input:not([type="hidden"]), textarea, select'
    );
    var initialValues = [];
    var allowLeave = false;

    function valueOf(field) {
        if (field.type === 'checkbox' || field.type === 'radio') {
            return field.checked;
        }

        return field.value;
    }

    for (var i = 0; i < fields.length; i++) {
        initialValues.push(valueOf(fields[i]));
    }

    function hasChanges() {
        for (var i = 0; i < fields.length; i++) {
            if (valueOf(fields[i]) !== initialValues[i]) {
                return true;
            }
        }

        return false;
    }

    document.addEventListener('click', function (event) {
        var link = event.target.closest('a[href]');

        if (link === null || !hasChanges() || link.target === '_blank'
                || event.defaultPrevented) {
            return;
        }

        var continuar = window.confirm(
            'Hay cambios sin guardar. ¿Deseas continuar sin guardarlos?'
        );

        if (!continuar) {
            event.preventDefault();
        } else {
            allowLeave = true;
        }
    });

    form.addEventListener('submit', function () {
        allowLeave = true;
    });

    window.addEventListener('beforeunload', function (event) {
        if (!allowLeave && hasChanges()) {
            event.preventDefault();
            event.returnValue = '';
        }
    });
})();
