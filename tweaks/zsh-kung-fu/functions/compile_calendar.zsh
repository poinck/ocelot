calendar() {

  calendar_exe="$XDG_CACHE_HOME/calendar"

  if [[ ! -f "${calendar_exe}" ]] ; then

    if [[ -f "/etc/makepkg.conf" ]] ; then
        compile_flagz=($(gawk -F '"' '/^CFLAGS/ {print $2}' /etc/makepkg.conf))
    else
        compile_flagz=("-O2")
    fi

    the_calendar=('
#include <stdlib.h>
#include <gtk/gtk.h>

int main (int argc, char *argv[])
{
    GtkWidget *window, *box, *calendar;
    gtk_init(&argc, &argv);

    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(window), "Calendar");

    box = gtk_box_new(FALSE, 0);
    gtk_container_add(GTK_CONTAINER(window), box);

    calendar = gtk_calendar_new();
    gtk_container_add(GTK_CONTAINER(box), calendar);

    g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(gtk_main_quit), NULL);
    gtk_widget_show_all(window);
    gtk_main();

    return EXIT_SUCCESS;
}
')
    cat <<EOF > /tmp/calendar.c
${the_calendar[@]}
EOF

    # you need to install gtk2 OR gtk3
    # gtk2 instructions - change the above:
    # 'gtk_box_new' with 'gtk_vbox_new'
    # now change the below:
    # --libs gtk+-3.0 with --libs gtk+-2.0

    gcc -Wall -Wextra $compile_flagz[@] -o $calendar_exe \
        /tmp/calendar.c `pkg-config --cflags --libs gtk+-3.0`

  fi
  "${calendar_exe}"
}
