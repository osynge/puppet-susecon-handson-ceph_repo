class ceph_repo {

    package { createrepo:
        ensure => latest,
        allow_virtual => false,
    }
    package { rbd-kmp-default:
        ensure => latest,
        allow_virtual => false,
    }
    package { ntp:
        ensure => latest,
        allow_virtual => false,
    }
    group {"ntp":
        ensure => "present",
        require => Package["ntp"],
    }
    file { "/etc/ntp.conf":
        owner   => root,
        group   => ntp,
        mode    => 0640,
        source  => "puppet:///modules/ceph_repo/ntp.conf",
        require => Group["ntp"],
        notify  => Service["ntpd"],
    }
    service { 'ntpd':
        ensure  => "running",
        enable    => true,
        hasstatus => false,
        require   => File["/etc/ntp.conf"],
    }
    file { "/etc/ssh/sshd_config":
        owner   => root,
        group   => root,
        mode    => 0640,
        source  => "puppet:///modules/ceph_repo/sshd_config",
        notify  => Service["sshd"],
    }
    service { 'sshd':
        ensure  => "running",
        enable    => true,
        hasstatus => false,
        require   => File["/etc/ssh/sshd_config"],
    }
    file { "/etc/zypp/repos.d/ceph_demo.repo":
        owner   => root,
        group   => root,
        mode    => 0644,
        source  => "puppet:///modules/ceph_repo/ceph_demo.repo",
    }
    group {"ceph":
        ensure => "present",
    }

    user { "ceph":
                comment => "ceph user",
                ensure => "present",
                gid => "ceph",
                home => "/home/ceph",
                managehome => true,
                shell => "/bin/bash",
                uid => 429294,
                require => Group["ceph"],
    }
    ssh_authorized_key { 'osynge@suse.com-ceph':
         user => 'ceph',
         type => 'ssh-rsa',
         key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA0YVRKEgDrzb/Wh+Wz0xnK7TZ/bmN7NB4c22oqwi3s3t2YxLk51OeMPztG7NKV0vp3A179zrjA33nxbLhPaQM1v9vFVn0sIWn2dQwZOIeL+mezOWOp20+voHNT+uZq1CLeISUxYfADPYYtWNTRfItMALHywcZiW/E3qQ5G8bL2czznpnWe8jjE468r0lKuTWp5h6glsvITapVqpg2M44FiQjo5f7UEiH5vbegaUq8mcXwV/OC1w29Qsg1/uULWwYefsYJyyA2KG0FmtxlkB+SMGT2y4OwLLfj16Cu4kLaRoE2asJs2bZyDKAhthSYFinh46fR2ymRo/qSt5E43+uT4Q==',
         ensure => 'present',
         require => Group["ceph"],
    }

    ssh_authorized_key { 'osynge@suse.com-ec2-user':
         user => 'ec2-user',
         type => 'ssh-rsa',
         key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA0YVRKEgDrzb/Wh+Wz0xnK7TZ/bmN7NB4c22oqwi3s3t2YxLk51OeMPztG7NKV0vp3A179zrjA33nxbLhPaQM1v9vFVn0sIWn2dQwZOIeL+mezOWOp20+voHNT+uZq1CLeISUxYfADPYYtWNTRfItMALHywcZiW/E3qQ5G8bL2czznpnWe8jjE468r0lKuTWp5h6glsvITapVqpg2M44FiQjo5f7UEiH5vbegaUq8mcXwV/OC1w29Qsg1/uULWwYefsYJyyA2KG0FmtxlkB+SMGT2y4OwLLfj16Cu4kLaRoE2asJs2bZyDKAhthSYFinh46fR2ymRo/qSt5E43+uT4Q==',
         ensure => 'present',
         require => Group["ceph"],
    }

    ssh_authorized_key { 'aspiers@suse.com-ceph':
         user => 'ceph',
         type => 'ssh-rsa',
         key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDBmeaWjJnIx4VjtCjxFQ9oVhPdo0Bk3CbjyXrKe1wsTiHaTBmnqciA/5O5/YGENnieukcmxz+7rEel5RImoT3sBhrWuP9dKspguAXYOzjSbW2CKbGLqgwqjp1JniYxG0FEjvJ1ddavNY/A4/ApOU1bQwlvytt+pG+FQnQZ3X0YV+I+trvpIPFT48ngUpKoJLIp12MDZObbwdroNxW2aYma/JYeqgWxwtSBPlKo4Dulc1hOuGqS6+4mKWqoScD6KXGbKunKwRexSjVVkd6Sc3c1CgFa+uBBZAdOj/J773Ww7VZZ0KPvjTjLK5aqBAqhIwQHO/yFtzkesunCSucin4oH',
         ensure => 'present',
         require => Group["ceph"],
    }

    ssh_authorized_key { 'aspiers@suse.com-ec2-user':
         user => 'ec2-user',
         type => 'ssh-rsa',
         key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDBmeaWjJnIx4VjtCjxFQ9oVhPdo0Bk3CbjyXrKe1wsTiHaTBmnqciA/5O5/YGENnieukcmxz+7rEel5RImoT3sBhrWuP9dKspguAXYOzjSbW2CKbGLqgwqjp1JniYxG0FEjvJ1ddavNY/A4/ApOU1bQwlvytt+pG+FQnQZ3X0YV+I+trvpIPFT48ngUpKoJLIp12MDZObbwdroNxW2aYma/JYeqgWxwtSBPlKo4Dulc1hOuGqS6+4mKWqoScD6KXGbKunKwRexSjVVkd6Sc3c1CgFa+uBBZAdOj/J773Ww7VZZ0KPvjTjLK5aqBAqhIwQHO/yFtzkesunCSucin4oH',
         ensure => 'present',
         require => Group["ceph"],
    }

    ssh_authorized_key { 'tbehrens@suse.com-ceph':
         user => 'ceph',
         type => 'ssh-rsa',
         key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCgs9BVIat7LhEZI/IO18H5KdM/0SiA8GiY+gVp4yeK3vojN13qQ6QjU4hsIbu9dw9Wg890+MFEZhZhv9Z6AvNinzAsxCVuOtsLRfiO5SFVxUA0LxrRVhuZtyfwzzC6mNgNZqN4us5lzzkRV62ZvRYmkwQMjaRG6iZxP2ckNxiSyu2GC0VEfMAiBlk/2HfuN+Z02aj2nGCEnHt+pihTWpqaS0WW9Ex7gX1yi7DybPHANIHcddq/o0/sbuD7m5ZX9AwKJaFoONBTo8HJWeStoGSBHU01Z389XMq3m+ljIsRuwAm+Q4NvBruh8NcmotZvffSSJv7k2EIGQbDLWAjr5/cngLQ4ujPi98DyQYlwhMMKxYnwmafMlIZZbwUlO/Jl8i6vn5rQFIHI1p9Ey3YsR8b+IEKe3aBxLBnTuTgVIogSw+QcqkH+o3dxjNHOR9Uqc6Q6rkof0zaBGQtkED+BdtwJVAQGDwx67T2Fvm2E7zIPeSelKzUI5HpJf8F3vEYgDnVsBgN4FFv9TarcyFkjtrh0Fmf08FRXxds4VbIRbi4Qg+WNSGxMmvYMYtEYKFeZhAaij7/zLdetl1Tcsd3HmQKvq9IeN9l00ovytdThEmn59YGsiLIHb33zHIsuzFEkckxyDQVEo4mvjOAenq7Pg0b0KJDkHXJBdX/xUdKoef5Qaw==',
         ensure => 'present',
         require => Group["ceph"],
    }

    ssh_authorized_key { 'tbehrens@suse.com-ec2-user':
         user => 'ec2-user',
         type => 'ssh-rsa',
         key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCgs9BVIat7LhEZI/IO18H5KdM/0SiA8GiY+gVp4yeK3vojN13qQ6QjU4hsIbu9dw9Wg890+MFEZhZhv9Z6AvNinzAsxCVuOtsLRfiO5SFVxUA0LxrRVhuZtyfwzzC6mNgNZqN4us5lzzkRV62ZvRYmkwQMjaRG6iZxP2ckNxiSyu2GC0VEfMAiBlk/2HfuN+Z02aj2nGCEnHt+pihTWpqaS0WW9Ex7gX1yi7DybPHANIHcddq/o0/sbuD7m5ZX9AwKJaFoONBTo8HJWeStoGSBHU01Z389XMq3m+ljIsRuwAm+Q4NvBruh8NcmotZvffSSJv7k2EIGQbDLWAjr5/cngLQ4ujPi98DyQYlwhMMKxYnwmafMlIZZbwUlO/Jl8i6vn5rQFIHI1p9Ey3YsR8b+IEKe3aBxLBnTuTgVIogSw+QcqkH+o3dxjNHOR9Uqc6Q6rkof0zaBGQtkED+BdtwJVAQGDwx67T2Fvm2E7zIPeSelKzUI5HpJf8F3vEYgDnVsBgN4FFv9TarcyFkjtrh0Fmf08FRXxds4VbIRbi4Qg+WNSGxMmvYMYtEYKFeZhAaij7/zLdetl1Tcsd3HmQKvq9IeN9l00ovytdThEmn59YGsiLIHb33zHIsuzFEkckxyDQVEo4mvjOAenq7Pg0b0KJDkHXJBdX/xUdKoef5Qaw==',
         ensure => 'present',
         require => Group["ceph"],
    }

    ssh_authorized_key { 'student@suseconferance_2014':
         user => 'ec2-user',
         type => 'ssh-rsa',
         key  => 'AAAAB3NzaC1yc2EAAAADAQABAAAB+wDITVS08Ov6cSG0H9o0nMgMYxHOh5gZs/s+DCUEN9oFNvWCvwI6uVjCe9pXZxtZgyb+j8vkJQDG2Xvoc/zg2YbRVI/akXE74ckHqvMiAU5vxB6QjmOZvyCsKQEjUjcXvSQuqtmuKeTudbUyZyWQ8dLTs0v6qLtwR0CHU1ztgSDNs3pGqH7fLi7NysAiHWVChFOFVH6BqwF8LOYJOnlNa147Ap3d/n/lP1a0p73WY88pAwqlKEgDqttKfdpRY+bKxyGQEIyw/LWEVvyo74W28V5ELD+LXIk0aa7PcXOgdleBmnSfSVFdwm2Ijze1c4zP+dBGGKYkQWE6mnmNnPADnrIMvgfUM7V0mceJJsbHZID8HARVPcKerB2oAwV2hDbGbupWrrs7oNREB0Gx0895NcyCucRPEw1BbDDfAAm1aF7TKbFjX7cuGm+mxip++pBxP91eiu+7RZViXaiGRwm3pvsPPDmjHvn6Ajb7gpgQF1lihM/7HHYEkUygzyNpNLF6XvXdQ7lyMcMxSVKSU26+LNj0bXMPfkNjbCc8K8U4OhNL8FosMLAby4dufRKIwcAVqId+Ph/5UwrD8rGuIA4SHPE3qD4DuPFoff/6tORT20VKihc8XdRI7v/xSVDCEg91uzkger5mm40XWNhh0PGv6Lsw6f3e/Wqr/oRMqw==',
         ensure => 'present',
         require => Group["ceph"],
    }

/*

    package { 'ceph-deploy':
        ensure => latest,
        name => 'ceph-deploy',
        require => File["/etc/zypp/repos.d/ceph_demo.repo"],,
        allow_virtual => false
    }
*/
    file { "/etc/sudoers.d/ceph":
        owner   => root,
        group   => root,
        mode    => 0644,
        source  => "puppet:///modules/ceph_repo/ceph_sudo",
    }


}

